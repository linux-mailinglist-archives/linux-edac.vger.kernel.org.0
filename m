Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9571D6700
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfJNQPL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 12:15:11 -0400
Received: from foss.arm.com ([217.140.110.172]:48080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfJNQPK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 12:15:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE8528;
        Mon, 14 Oct 2019 09:15:10 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32DAA3F718;
        Mon, 14 Oct 2019 09:15:09 -0700 (PDT)
Subject: Re: edac KASAN warning in experimental arm64 allmodconfig boot
To:     John Garry <john.garry@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tony.luck@intel.com, Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com>
Date:   Mon, 14 Oct 2019 17:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi John,

On 14/10/2019 16:18, John Garry wrote:
> I'm experimenting by trying to boot an allmodconfig arm64 kernel, as mentioned here:

Crumbs!


> One thing that I noticed - it's hard to miss actually - is the amount of complaining from
> KASAN about the EDAC/ghes code. Maybe this is something I should not care about/red
> herring, or maybe something genuine. Let me know what you think.

Hmmm, I thought I tested this recently...

> Log snippet (I cut off after the first KASAN warning):
> 
> [   70.471011][    T1] random: get_random_u32 called from new_slab+0x360/0x698 with
> crng_init=0

> [   70.478671][    T1] [Firmware Bug]: APEI: Invalid bit width + offset in GAR
> [0x94110034/64/0/3/0]

(this one's for you right?)

> [   70.700412][    T1] ------------[ cut here ]------------

> [   70.802080][    T1] Call trace:
> [   70.802093][    T1]  debug_print_object+0xec/0x130
> [   70.802106][    T1]  __debug_check_no_obj_freed+0x114/0x290
> [   70.802119][    T1]  debug_check_no_obj_freed+0x18/0x28
> [   70.802130][    T1]  slab_free_freelist_hook+0x18c/0x228
> [   70.802140][    T1]  kfree+0x264/0x420
> [   70.802157][    T1]  _edac_mc_free+0x6c/0x210
> [   70.814163][    T1]  edac_mc_free+0x68/0x88
> [   70.814177][    T1]  ghes_edac_unregister+0x44/0x70
> [   70.814193][    T1]  ghes_remove+0x274/0x2a0

Ugh. This must be the test driver remove thing.

I've reproduced this, but had to remove the parent GHES twice. It looks like it tries to
use the first ghes_edac global variables when freeing the second. ghes_init prevents it
from re-allocating over the top.

The below diff fixes it for me. (I'll post it as a proper patch once I've done the
archaeology)

-----------%<-----------
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d413a0bdc9ad..955b59b6aade 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -554,6 +554,7 @@ void ghes_edac_unregister(struct ghes *ghes)
                return;

        mci = ghes_pvt->mci;
+       ghes_pvt = NULL;
        edac_mc_del_mc(mci->pdev);
        edac_mc_free(mci);
 }

-----------%<-----------


Thanks!

James

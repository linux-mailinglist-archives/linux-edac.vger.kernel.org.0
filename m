Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8B5880C
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2019 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfF0RLV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jun 2019 13:11:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0RLV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jun 2019 13:11:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6CC360;
        Thu, 27 Jun 2019 10:11:21 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0733F718;
        Thu, 27 Jun 2019 10:11:20 -0700 (PDT)
Subject: Re: [PATCH] EDAC: Fix global-out-of-bounds write when setting
 edac_mc_poll_msec
To:     Eiichi Tsukata <devel@etsukata.com>
References: <20190626054011.30044-1-devel@etsukata.com>
From:   James Morse <james.morse@arm.com>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Message-ID: <ee91dd9d-e9ac-4fee-d7f2-152195995ecb@arm.com>
Date:   Thu, 27 Jun 2019 18:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626054011.30044-1-devel@etsukata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

(CC: +Tony Luck.
 Original Patch: lore.kernel.org/r/20190626054011.30044-1-devel@etsukata.com )

On 26/06/2019 06:40, Eiichi Tsukata wrote:
> Commit 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2") assumes
> edac_mc_poll_msec to be unsigned long, but the type of the variable still
> remained as int. Setting edac_mc_poll_msec can trigger out-of-bounds
> write.

Thanks for catching this!


> Fix it by changing the type of edac_mc_poll_msec to unsigned int.

This means reverting more of 9da21b1509d8, but it also fixes signed/unsigned issues:
| root@debian-guest:/sys/module/edac_core/parameters# echo 4294967295 >  edac_mc_poll_msec
| root@debian-guest:/sys/module/edac_core/parameters# cat edac_mc_poll_msec
| -1
| root@debian-guest:/sys/module/edac_core/parameters# echo -1 > edac_mc_poll_msec
| -bash: echo: write error: Invalid argument


> The reason why this patch adopts unsigned int rather than unsigned long
> is msecs_to_jiffies() assumes arg to be unsigned int.

Ah, so the range is limited anyway.

It looks like it was switched to long to be consistent with edac_mc_workq_setup(), which
has since been removed in preference to msecs_to_jiffies().


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3226A7FF38
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbfHBRFK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 13:05:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403954AbfHBRFJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 13:05:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 120ED344;
        Fri,  2 Aug 2019 10:05:09 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6082D3F575;
        Fri,  2 Aug 2019 10:05:08 -0700 (PDT)
Subject: Re: [PATCH v2 15/24] EDAC, ghes: Extract numa node information for
 each dimm
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-16-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com>
Date:   Fri, 2 Aug 2019 18:05:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624150758.6695-16-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 24/06/2019 16:09, Robert Richter wrote:
> In a later patch we want to have one mc device per node. This patch
> extracts the numa node information for each dimm. This is done by
> collecting the physical address ranges from the DMI table (Memory
> Array Mapped Address - Type 19 of SMBIOS spec). The node information
> for a physical address is already know to a numa aware system (e.g. by
> using the ACPI _PXM method or the ACPI SRAT table), so based on the PA
> we can assign the node id to the dimms.

I really don't like the way this depends on the rest of the kernel's NUMA support.
mm's policies around the placement of data change with these settings, that shouldn't
matter here. Reporting physical errors shouldn't be influenced by mm's placement policy.

pfn_valid() is a sore subject on arm64, it will return false for random pages that the
firmware is using, or wrote data to with unusual memory attributes. Depending on it makes
this code fragile...


> A fallback that disables numa is implemented in case the node
> information is inconsistent.

... which is why you need a fallback.

All this makes it difficult to explain why this things view of memory is as it is.
Making the RAS/edac code unpredictable like this is a hard sell.

You need to squint through Kconfig, SRAT and the UEFI memory map.
(due to pfn_valid(): the behaviour here can change over a reboot)


Can we 'just' use the type-16 handle to group the DIMMs?

As an illustration:
http://www.linux-arm.org/git?p=linux-jm.git;a=shortlog;h=refs/heads/edac_ghes_2level_dimms/v0

This reflects the SMBIOS tables on my NUMA desktop, and doesn't depend on any of the
above. I'd be interested to know what is missing from this approach.

(which numa node? I don't think we need to know the mapping of mcX<->nid up front. We can
find it from the faulting physical address when we get an error report).


N.B, your mail is still arriving base64 encoded. It looks like this:
https://lore.kernel.org/linux-edac/20190624150758.6695-16-rrichter@marvell.com/raw

Lei Wang found:
> Ah I found if without explicit "--transfer-encoding=7bit" when do "git
> send-mail", my ubuntu box sent out base64 by default.

(but his mail didn't get archived for some reason)


Thanks,

James

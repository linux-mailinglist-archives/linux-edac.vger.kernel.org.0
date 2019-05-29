Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8501F2E0B5
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfE2PMm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:12:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PMl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:12:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B4B15AD;
        Wed, 29 May 2019 08:12:41 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C383F5AF;
        Wed, 29 May 2019 08:12:40 -0700 (PDT)
Subject: Re: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-12-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <37d47356-a40b-2739-10df-f5ab83fa2b36@arm.com>
Date:   Wed, 29 May 2019 16:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-12-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> Almost duplicate code, remove it.

almost?


> Note: there is a difference in the calculation of the grain_bits,
> using the edac_mc's version here.

But is it the right thing to do?

Is this an off-by-one bug being papered over as some cleanup?
If so could you post a separate fix that can be picked up for an rc.

Do Marvell have firmware that populates this field?

...

Unless the argument is no one cares about this...

From ghes_edac_report_mem_error():
|	/* Error grain */
|	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
|		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);

Fishy, why would the kernel page-size be relevant here?

If physical_addr_mask were the same as PAGE_MASK this wouldn't this always give ~0?
(masking logic like this always does my head in)

/me gives it ago:
| {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
| {1}[Hardware Error]:   physical_address_mask: 0xffffffffffff0000
| {1}[Hardware Error]:   error_type: 6, master abort
| EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
| grain:-1 syndrome:0x0 - status(0x0000000000000001): reserved)

That 'grain:-1' is because the calculated e->grain was an unlikely 0xffffffffffffffff.
Patch incoming, if you could test it on your platform that'd be great.

I don't think ghes_edac.c wants this '+1'.


Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40599396553
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhEaQbz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhEaQ3w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 12:29:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F44C061231;
        Mon, 31 May 2021 07:57:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f002c54d32600da041e.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:2c54:d326:da:41e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE2831EC03D5;
        Mon, 31 May 2021 16:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622473068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q7UmMu6yCEwDn6Mhju/5FZSpRM+RHoqO1YzwnVQdAIc=;
        b=CnuqzZp9CdIqZCLzQ/uVm/VkRZPAVWiKX6Ujd8k8/5gz7ZyPKx2HrfSRB8bHOcPB0Ndx2x
        5If4ygHSaRaj2YwFd+7G3YcIUzLndyEgJVBDtJXeT4C5hEUIpFT+99CAf5zBRUpjPIsbBI
        B4beGHQQWlCAKGw5o9PAQfLZgl7YT4c=
Date:   Mon, 31 May 2021 16:57:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jan Luebbe <jlu@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        York Sun <york.sun@nxp.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] edac: Use 'ret' instead of 'res' to store the
 return value
Message-ID: <YLT5Y+FRhUWWszOq@zn.tnic>
References: <20210531145302.9655-1-thunder.leizhen@huawei.com>
 <20210531145302.9655-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210531145302.9655-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 31, 2021 at 10:53:02PM +0800, Zhen Lei wrote:
> Usually 'ret' or 'rc' is used as the abbreviation for 'return code', and
> 'res' is used as the abbreviation for 'resource'.

Or "result."

Please refrain from doing pointless patches like that - it is a totally
unnecessary churn.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

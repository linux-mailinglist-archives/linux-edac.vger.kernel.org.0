Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70B321301
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 10:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBVJYs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 04:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBVJYr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 04:24:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5EC061574;
        Mon, 22 Feb 2021 01:24:06 -0800 (PST)
Received: from zn.tnic (p200300ec2f040200a034b7f44a0c99a8.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:200:a034:b7f4:4a0c:99a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D11F1EC025A;
        Mon, 22 Feb 2021 10:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613985844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kPzv+4BLBRuKuhBJEdIH/HePcme0g8FNkpnOb1T+LNM=;
        b=JcRAIR15gSS+1EnjWjbeyu1yGqwQoXfao3U6a/CCrHoH5237m89Js63VHINWkgWvMhkdIP
        bzhOKsBXdl7lgU1xiQA6IcC9+A1RcZmkPTtuB3Q8OT+5Z9dtXMReidUXFvmiUaQrSJd8cu
        jlEPuKV9xi9nJB4bSAECvJtNEGpysOg=
Date:   Mon, 22 Feb 2021 10:24:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222092403.GA29063@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
 <20210222115007.75b7de9b@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222115007.75b7de9b@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 11:50:07AM +0800, Aili Yao wrote:
> From commit b2f9d678e28c ("x86/mce: Check for faults tagged in
> EXTABLE_CLASS_FAULT exception table entries"), When there is a
> memory MCE_AR_SEVERITY error with no return ip,

What is a "no return ip" - MCG_STATUS_RIPV?

How do you trigger this error?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

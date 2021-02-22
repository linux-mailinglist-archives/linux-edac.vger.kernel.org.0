Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAD321409
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBVKW5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 05:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhBVKWs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 05:22:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEEC061786;
        Mon, 22 Feb 2021 02:22:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f040200a034b7f44a0c99a8.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:200:a034:b7f4:4a0c:99a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E207F1EC0323;
        Mon, 22 Feb 2021 11:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613989327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9UJpE2XmXjqNjTRz2nvD9/bdrjQ0X8OvHEMTp53Ji5g=;
        b=jfjqx1RIIJ++hO3NQg2mav75eRFliGKk+czEWSfR7K+3PwgBz88YkugIschtIJkMv4JIqv
        EJN3tPI/47VcCVkHvlFOHAYSQxrV0bPshkZKhUiGjGVs3niVTeCSg8LTNx/45Uxl/3rWFR
        ryABfuCDtTBhFIfPXXCa2iJzUJcGXS8=
Date:   Mon, 22 Feb 2021 11:22:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222102206.GC29063@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
 <20210222115007.75b7de9b@alex-virtual-machine>
 <20210222092403.GA29063@zn.tnic>
 <20210222173109.7b7ac42a@alex-virtual-machine>
 <20210222100356.GB29063@zn.tnic>
 <20210222180819.3998fe33@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222180819.3998fe33@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 06:08:19PM +0800, Aili Yao wrote:
> So why would intel provide this MCG_STATUS_RIPV flag, it's better to
> remove it as it will never be set, and all the related logic for this
> flag is really needed ?

Why would it never be set - of course it will be. You don't set it. If
you wanna inject errors, then make sure you inject *valid* errors which
the hardware *actually* generates, not some random ones.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

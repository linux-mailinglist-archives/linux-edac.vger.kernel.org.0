Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D144B4C3
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 22:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKIVc4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 16:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhKIVc4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 16:32:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66AC061764;
        Tue,  9 Nov 2021 13:30:09 -0800 (PST)
Received: from zn.tnic (p200300ec2f18aa00aec912b1b11fde1a.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:aec9:12b1:b11f:de1a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE48F1EC0390;
        Tue,  9 Nov 2021 22:30:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636493408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Na1GO8CHHfkH7PTogxxL39ysdX5U41PDDHRMkhNbsVk=;
        b=NDKwOXu5H+BVEopZN1+LF2gcd+5OR1YGOFBcHcPb6s9mu0b2s6wJm547IswbKTMjd0agCH
        nnP8dIu0efCcUUshzNOTmvlr9fliZVwgJ8ds1CBDkVAXU2Vb3T7SCLwG3MySfJ6P18HKhQ
        Z9fYWCpXrW13TCkRPuzYxl2RkTgLR0w=
Date:   Tue, 9 Nov 2021 22:30:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYroWYUVJEVKqy+7@zn.tnic>
References: <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic>
 <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
 <YYrQe7bYe+OBzZ4B@zn.tnic>
 <84e2622e4300490587793d2509f7b3ff@intel.com>
 <YYrYUpM7c5Z+nFsv@zn.tnic>
 <42d1d11d63f3453db61fad58a91e2ba5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42d1d11d63f3453db61fad58a91e2ba5@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 08:44:41PM +0000, Luck, Tony wrote:
> > what do we do with the sysfs knob? It probably is an ABI:
> >
> > /sys/devices/system/machinecheck/machinecheck1/tolerant
> > /sys/devices/system/machinecheck/machinecheck2/tolerant
> 
> $ git grep tolerant -- Documentation/ABI/
> $
> 
> An undocumented ABI! Well, not documented with all the other sysfs bits.
> 
> It does appear in:
> Documentation/x86/x86_64/machinecheck.rst

Yeah, we have some spreading of documentation which is not necessarily
helpful.

> Of course, like a lot of documentation, it isn't accurate. It wasn't
> updated to describe what happens with recoverable errors. Final
> paragraph says:
>
>         Note this only makes a difference if the CPU allows recovery
>         from a machine check exception. Current x86 CPUs generally do
>         not.
>
> Recovery was first introduced in the Nehalem generation which
> ark.intel.com says was launched in Q1'2010. So over a decade.
>
> Choices: 1) Leave the file there, but remove the code that uses the
> value 2) Delete the file too
>
> Option 1 doesn't break any scripts that look for the file, but may
> make people shout louder when they find it no longer does anything.
>
> Option 2 is the more honest approach.

Ack, we can try 2 and see who cries.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

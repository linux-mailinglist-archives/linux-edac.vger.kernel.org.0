Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4144B37D
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhKITvG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 14:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhKITvG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 14:51:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F15C061764;
        Tue,  9 Nov 2021 11:48:20 -0800 (PST)
Received: from zn.tnic (p200300ec2f18aa00db849a68730b2e8f.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:db84:9a68:730b:2e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F34671EC0532;
        Tue,  9 Nov 2021 20:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636487298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zfZ2iWFL4Fzq+K7vcXar31juA1wrp691cgDQW8C2NpI=;
        b=OG0YGadcoZVaT0jFItmVtrUGplmifxcdLzCX5IjNQ9C6zMyshN5iBmlv0GNmBLUsFqk2Wx
        PxLWpZ3Wz+aFpXwPDbCzJFqaDAKS3BkqXk9oBinAzcM7WdyFBF0wk5K2T6rMeX/1EEZ8S/
        dHH90AK+SKAuS8LFdqZYWObw2bhFpDQ=
Date:   Tue, 9 Nov 2021 20:48:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYrQe7bYe+OBzZ4B@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com>
 <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic>
 <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 04:06:48PM +0000, Luck, Tony wrote:
> Just a note that skipping the mce_panic() here isn't going to help
> much. With some CPUs stuck not responding to #MC the system is going
> to lock up or crash for other timeouts in the next few seconds.

Yeh, I spent a couple of minutes today staring at this ->tolerant
thing and wondering why we need it at all. I wouldn't mind ripping it
altogether unless you're using it for testing or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

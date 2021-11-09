Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836A44B3E1
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhKIUYc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 15:24:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244248AbhKIUYb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 15:24:31 -0500
Received: from zn.tnic (p200300ec2f18aa00db849a68730b2e8f.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:db84:9a68:730b:2e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52BDB1EC0464;
        Tue,  9 Nov 2021 21:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636489304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KpzY1AOuRaRi2PTOHlLg1Dz8pMQgnCDe1iU/b1CcYQ0=;
        b=q6wonHiwIQA5spQaj1INTCvve+DcDdiSohhf8xOIiALr7MO95+rO+ld3R13tAh51Hpp/I2
        5o+YiVKi+sqpa1aekDZ3MfoZBWNrKPfpUrV1Hm9F4E9vtzDBV041zXJNNRthisbN4X95Yn
        CgIISqSk0MSbGYH6227brAuY/XKyZK0=
Date:   Tue, 9 Nov 2021 21:21:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYrYUpM7c5Z+nFsv@zn.tnic>
References: <20211108082832.142436-1-zhangzl2013@126.com>
 <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic>
 <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
 <YYrQe7bYe+OBzZ4B@zn.tnic>
 <84e2622e4300490587793d2509f7b3ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84e2622e4300490587793d2509f7b3ff@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 07:50:57PM +0000, Luck, Tony wrote:
> I think it might have been useful before recoverable machine checks. But
> now it just seems to cause confusion. I do not ever use it. I would not be
> sad to see it go.

Yeah,

what do we do with the sysfs knob? It probably is an ABI:

/sys/devices/system/machinecheck/machinecheck1/tolerant
/sys/devices/system/machinecheck/machinecheck2/tolerant
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275B32B99E6
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 18:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgKSRpQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 12:45:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45584 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbgKSRpQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Nov 2020 12:45:16 -0500
Received: from zn.tnic (p200300ec2f0caf00213cbc20ee7f6949.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:213c:bc20:ee7f:6949])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B10881EC04D3;
        Thu, 19 Nov 2020 18:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605807914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m8iQDyfCg54X8Y1uTZbWsdh1r6Ik6jbOt5fBy42wZTI=;
        b=Ye2+mNOgQh9UIxuEF+Q6Yc2XK5Ttz628Yggr7b9hBozeccW0eJ7ODhJPWjArKLZdUHtgm6
        EoAzqOmpCx9BBLgnmbR79qy4SUnMv81QXLzm924+Hm3UmbjzxEkABQzXuQMqDKgUKEgzbN
        xe9cGuym3tf9pVHZ+HjMQc9M230adGk=
Date:   Thu, 19 Nov 2020 18:45:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, yangfeng1@kingsoft.com,
        CHENGUOMIN@kingsoft.com
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201119174508.GE3769@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
 <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
 <20201118124538.GI7472@zn.tnic>
 <20201119134057.37ca2c19.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119134057.37ca2c19.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 19, 2020 at 01:40:57PM +0800, Aili Yao wrote:
> [    0.000000] Linux version 4.18.0+  #37 SMP Thu Nov 19 10:38:16 CST 2020

Ok, before we look any further into this, please redo the whole exercise
with the latest upstream kernel - not some 4.18 old crap. Use the
tip/master branch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=master

And then paste results again according to the scheme.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

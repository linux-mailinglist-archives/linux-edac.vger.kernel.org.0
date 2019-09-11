Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DF8B0060
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfIKPko (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 11:40:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPko (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Sep 2019 11:40:44 -0400
Received: from zn.tnic (p200300EC2F0BA90014C938BBBD6B6EBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:a900:14c9:38bb:bd6b:6ebd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B24551EC0260;
        Wed, 11 Sep 2019 17:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568216442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0XkV/Gz/13IJqBOxxhh8TZyo4mSOacc++RqAW+iwqYU=;
        b=Rm+awrlFXc/u5Sl6OTsLWmDmUyXs+19HWvYRVtZl6m3kvelXHxxph/I0vUx0Z1fYSe0Ka4
        uvfPk+iWYyRXW277fmgy4zT7wKAcRMzoo5FDxNamwczHPsw9Fl9/mcQGRNB3c9o8vPaasQ
        KHvihBjW5AJSvyMHIf5rygWvJKM7T0Y=
Date:   Wed, 11 Sep 2019 17:40:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH] x86/mce: add a switch of CONFIG_X86_MCELOG_LEGACY
Message-ID: <20190911154037.GB27910@zn.tnic>
References: <1568215730-11471-1-git-send-email-lixiaochun.2888@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568215730-11471-1-git-send-email-lixiaochun.2888@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 11, 2019 at 11:28:50PM +0800, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> Add CONFIG_X86_MCELOG_LEGACY to control the
> behavior of several functions be compiled.

... because?

Your commit messages structure should look something like this:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

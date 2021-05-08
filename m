Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5F37726D
	for <lists+linux-edac@lfdr.de>; Sat,  8 May 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhEHOea (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 May 2021 10:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHOea (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 May 2021 10:34:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6472C061574
        for <linux-edac@vger.kernel.org>; Sat,  8 May 2021 07:33:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c5300aeec222591b28502.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:5300:aeec:2225:91b2:8502])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA7011EC047F;
        Sat,  8 May 2021 16:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620484405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L7RlPNfIo6n+0Rz/6M2EkUySHWS8IV9BUg50l99rBQg=;
        b=BNuJgciceD3iEqsE65sn+voaca2IlKBUSCh+1cJ0AmJhEu1WyUGZVsHl869BverZqNbkk/
        /YHxQMR+AVWT1Zjs4eGKWbutlqWWNianQAGq71J638TcEGccBNGvVJBGLUQlvY8u8LnkOd
        Nz+pNiABPLup4ukPGxosHunYalkL0/k=
Date:   Sat, 8 May 2021 16:33:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lv Ying <lvying6@huawei.com>
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org,
        fanwentao@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Fix printk deadlock causing
 mce_timed_out panic
Message-ID: <YJahM9PaZ7Jefkbi@zn.tnic>
References: <20210509053229.GA2477949@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210509053229.GA2477949@localhost.localdomain>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 09, 2021 at 01:32:29PM +0800, Lv Ying wrote:
> The mce-inject SRAO broadcast error injection on 4-core CPU caused mce_timed_out
> panic as following:
> Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

A couple of things:

- how exactly do you do that injection, please give exact steps

- on which kernel, dmesg, .config etc

- anything specific about the hardware you're using

- always Cc lkml on patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

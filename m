Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7857D26CD
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfJJJ4z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 05:56:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJJJ4z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 05:56:55 -0400
Received: from zn.tnic (p200300EC2F0A6300C5CFCA1B921AC096.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:c5cf:ca1b:921a:c096])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81EE61EC090E;
        Thu, 10 Oct 2019 11:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570701413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e6mcRQ4AXg4SNNjx9VNna2lM1EIlPgcJ5KVvf9GPlJk=;
        b=NrgR5AoID7oq8I0GLpP9azjQXKq1RtKf18oTjaRklUhhFxD19ACxSfJbuk8KgK5IAD8FNN
        Q37BDeDagm1TaYmN189NuZYLamoDQcIQfX8l2F82By5t2ginFGXhsXLLnq0+b5qJRgAqgi
        yuXxnFo1FkRh7BVIZFECB0n1gF7MPBc=
Date:   Thu, 10 Oct 2019 11:56:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeff God <jfgaudreault@gmail.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191010095650.GC7658@zn.tnic>
References: <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 09, 2019 at 07:54:45PM -0400, Jeff God wrote:
> On my side I don't have that setting in my bios under AMD CBS.

Check all the BIOS menus.

> Would this setting also prevent error reporting at the OS level or is
> it just related to the injection?

Platform first error handling meands, the BIOS gets to see the error
first. So it depends. Yazen, do you have the whole PFEH functionality
documented somewhere?

> The only thing I could find in my bios about ecc is Auto (default),

It could be that your BIOS doesn't even have a switch to turn it off.

Yazen, do we have a way to figure out whether PFEH is enabled on the
platform, from the kernel?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

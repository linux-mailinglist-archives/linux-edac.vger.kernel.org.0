Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6F243B0E
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMNz5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNz4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Aug 2020 09:55:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930EC061757;
        Thu, 13 Aug 2020 06:55:56 -0700 (PDT)
Received: from [10.207.149.13] (x2f7f10d.dyn.telefonica.de [2.247.241.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 190881EC0114;
        Thu, 13 Aug 2020 15:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597326953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2z/QHuddfnPiYCOkwErP9Q7A8zbLlz2m298BDod3Gqs=;
        b=UaD+LFORpUZ94jY7wvDLxFlm+VMlPhvsi1PBR9sXzJ++KhbSthWiGp5ZKlL8PN9afnuNDq
        LfVu4MDdZ/K1otCuLxZXG98l8r3co4/Y+r47t2+Dgu9mOvE912ovATuq9v+mTTRrOUvJB1
        WIAjMV0yL0zoxjwpazwpwMKv7ittolg=
Date:   Thu, 13 Aug 2020 16:55:50 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200813134406.23dvvsulfxend5jx@redhat.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com> <20200813134406.23dvvsulfxend5jx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already initialized
To:     Aristeu Rozanski <aris@redhat.com>, Jason Baron <jbaron@akamai.com>
CC:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <FE8145F7-A6A9-446F-A13F-3A14CF6E1934@alien8.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On August 13, 2020 4:44:06 PM GMT+03:00, Aristeu Rozanski <aris@redhat=2Eco=
m> wrote:
>We tested this inside in machines having this issue and it works=2E
>Patch looks good to me=2E
>
>Acked-by: Aristeu Rozanski <aris@redhat=2Ecom>

So Tested-by: you ?


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 

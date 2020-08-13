Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F0243BF7
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMOzb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 10:55:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39982 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMOzb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Aug 2020 10:55:31 -0400
Received: from [10.160.33.22] (x590fed16.dyn.telefonica.de [89.15.237.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5B641EC03E3;
        Thu, 13 Aug 2020 16:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597330530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHxCTmXGnwS0DmCpfG0kv2I6EyAsjFYGzFtqeLFp7Bo=;
        b=LNLhtHh1M1emxPs1PQC2jPRAwWEtZhQ/lmY/FwjHTgVVi64OSSolwj1O8cqyzNsk2GBFpF
        Cwbk2il+VZXK3+CfjCQkYbsHfFLUU0S99wydsCYo1ZJvfPcyYzx8gzhjAC42WfdSlmU/py
        dapUNm59AeEWqaca6IXkRX9wNIvTrm4=
Date:   Thu, 13 Aug 2020 17:55:28 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200813141710.ug5ei4hxoorproi4@redhat.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com> <20200813134406.23dvvsulfxend5jx@redhat.com> <FE8145F7-A6A9-446F-A13F-3A14CF6E1934@alien8.de> <20200813141710.ug5ei4hxoorproi4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already initialized
To:     Aristeu Rozanski <aris@redhat.com>
CC:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <31B390C9-0172-4E0D-920C-19D27CA89C4D@alien8.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On August 13, 2020 5:17:10 PM GMT+03:00, Aristeu Rozanski <aris@redhat=2Eco=
m> wrote:
>> So Tested-by: you ?
>
>Not by me, "we" meant as in company=2E

"you" can also mean you as a company=2E ;-P

>Tested-by: Vishal Agrawal <vagrawal@redhat=2Ecom>

Thx=2E


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 

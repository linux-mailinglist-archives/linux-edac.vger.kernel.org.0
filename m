Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B75ACB97
	for <lists+linux-edac@lfdr.de>; Sun,  8 Sep 2019 10:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfIHIfn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Sep 2019 04:35:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfIHIfn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 8 Sep 2019 04:35:43 -0400
Received: from zn.tnic (p200300EC2F2BAF0051BF1FB1AFF5BFE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f2b:af00:51bf:1fb1:aff5:bfe4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E40491EC0688;
        Sun,  8 Sep 2019 10:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567931741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nDOD0D60JTw0fxRO6NNP2wgWWLN1ymY0nAulzexSte0=;
        b=iEgRF1Tn6Eyapa3GG+ZRXriK8/ECEFR355Uxxoja/aEd1UIw8G+j+o2V2dqE+pl3UcgXka
        h+J/myauIEev8OYAzTFe8yYqZH5s8jqy58XTAFVQMuzfep+XZ89Uy4f2i74TIVL3AGHl5q
        1VV4DiPWoUTt/mrVP1yT1COUBdvLWmM=
Date:   Sun, 8 Sep 2019 10:35:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
Message-ID: <20190908083535.GD16220@zn.tnic>
References: <20190905083745.6899-1-hhhawa@amazon.com>
 <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
 <50f5bc27-98da-ee3e-59dd-7252c3ed7a0a@amazon.com>
 <20190908081602.GC16220@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190908081602.GC16220@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Sep 08, 2019 at 10:16:02AM +0200, Borislav Petkov wrote:
> On Sun, Sep 08, 2019 at 10:58:31AM +0300, Hawa, Hanna wrote:
> > > Better use WARN_ON_ONCE() to avoid flooding.
> >
> > In case of two drivers using this function with wrong error count, only the
> > first WARN_ON_ONCE will catch in this case, and other will miss other wrong
> > usage of other edac device drivers.
> 
> The idea is to catch any driver using a 0 error count and fix it, not to
> flood dmesg. You want _ONCE.

... and you want to return early too, i.e.,

	if (WARN_ON_ONCE(!error_count))
		return;

Frankly, I'd even remove all the warning functionality and simply do

	if (!error_count)
		return;

but let's see how much it screams first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

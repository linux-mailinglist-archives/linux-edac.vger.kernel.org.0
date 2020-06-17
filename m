Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36DD1FD0CD
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFQPW3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQPW2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jun 2020 11:22:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C38C06174E;
        Wed, 17 Jun 2020 08:22:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bb000a115b7d9110c62d9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:a115:b7d9:110c:62d9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C32B1EC03C5;
        Wed, 17 Jun 2020 17:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592407347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jYDxX+7IAxeetjgcjqHuc8C8ajEs1SremN84jrW7G34=;
        b=FlJ8BA/rFfbHhRscG8JZf3811K+pYpyfbdCPV0v6xnQK4W6lGL1HZV6CKX8ywK1TcNpTwX
        FQbG4lKH89OkaajVBInGO2SrOZ4JfhlNjEV1J4gDy9EqrxpN0pO7m3XTFyVH8g6p5m7cJQ
        1qI06z91kpXtHxoEQ6OfLSKHyeP0YPw=
Date:   Wed, 17 Jun 2020 17:22:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacky Hu <hengqing.hu@gmail.com>,
        Alexander Monakov <amonakov@ispras.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com,
        clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Message-ID: <20200617152219.GG10118@zn.tnic>
References: <20200616180940.GN13515@zn.tnic>
 <20200617013255.391975-1-hengqing.hu@gmail.com>
 <20200617034028.GA1614@roeck-us.net>
 <20200617071927.GA398128@i716>
 <alpine.LNX.2.20.13.2006171739010.31660@monopod.intra.ispras.ru>
 <20200617150735.GA405893@i716>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617150735.GA405893@i716>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ok, both of you:

On Wed, Jun 17, 2020 at 11:07:35PM +0800, Jacky Hu wrote:
> Hi,
> 
> Sorry, I apologize for didn't do much lookup that you already did the patch
> submission before I submitted the patch.
> I have to say we are all programmed by the programs.
> Also I didn't submit to either of the lists.
> A few places I did looked at are below before I did the submission.
> https://pci-ids.ucw.cz/v2.2/pci.ids
> https://lore.kernel.org/patchwork/project/lkml/list/

Jacky, please do not top-post. Please adhere to the etiquette on public
mailing lists.

Alexander, things like that can happen and they pretty much do happen
everytime new hw comes out. Kernel development has exploded so much in
recent years so that it is absolutely normal to miss stuff. Hell, *we*
miss stuff too, from time to time.

So let's concentrate on the work pls.

Thank you both!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

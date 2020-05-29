Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26CE1E79B7
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2JsG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2JsE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 May 2020 05:48:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF636C03E969;
        Fri, 29 May 2020 02:48:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f5e0080f2cd34aea9096d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:80f2:cd34:aea9:96d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DC1F1EC02AC;
        Fri, 29 May 2020 11:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590745683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XpGYVaIrvzVcoTinGLvL4KJrmoZUDhZeRnH1Glh7gfI=;
        b=Q22bFrgTvPzsvmYlkM9MfpjuezT3RfqCEAzdC22rWXLoicrbxr4aI34ozU80pQWb+GH87D
        lDxKi/AeUmCxuTUOfCMZXvdh0v9JLtsEc3/7dkqSml0y++gtwB0BlYwbsJzp3OobirE/rM
        9N9V3xWeqTUs1DYzS/3lijqdsfTe7bo=
Date:   Fri, 29 May 2020 11:47:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
Message-ID: <20200529094758.GD9011@zn.tnic>
References: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
 <20200529093644.GC9011@zn.tnic>
 <c304a0b0-692a-0696-6750-05a3db6a4b42@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c304a0b0-692a-0696-6750-05a3db6a4b42@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 29, 2020 at 11:40:47AM +0200, Markus Elfring wrote:
> Have we got different programming expectations also around the application
> of the Linux coding style?

We have me stopping you from giving new submitters wrong review and bad
advice.

Please refrain from "reviewing" EDAC patches!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

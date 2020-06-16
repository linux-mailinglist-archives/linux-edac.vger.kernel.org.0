Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D541FB518
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgFPOzL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOzL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 10:55:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571AAC061573;
        Tue, 16 Jun 2020 07:55:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c00fc4f770d23423cf8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:fc4f:770d:2342:3cf8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C0271EC0105;
        Tue, 16 Jun 2020 16:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592319308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kFkypjbdP/vo6vFlfenF45SwDu1Af+aAxvzK8DH0D/E=;
        b=Wy455MzSJMKKi6Y3/SZZuHPIFkc2iTfegGA7tuEi0hft+0Djp3cnUpathkxps352FmM32x
        k0eGBWtqtmz6Osvdq48WZ4MBpXGa7M53M+45BLkK1HN4o6L7dQb+6f5MQLWUVmzHuN4S4N
        hBtfWz/ewWGP6w63fyiNO7GQNjxhFDo=
Date:   Tue, 16 Jun 2020 16:55:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jacky Hu <hengqing.hu@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Message-ID: <20200616145501.GI13515@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200615115950.GG14668@zn.tnic>
 <a9d0cfc4-1aed-d6ed-c6f2-336b56d91f20@roeck-us.net>
 <20200616143517.GH13515@zn.tnic>
 <a2f55a9c-25fd-d79d-5f20-8144694f394d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2f55a9c-25fd-d79d-5f20-8144694f394d@roeck-us.net>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 16, 2020 at 07:46:36AM -0700, Guenter Roeck wrote:
> No, that is independent. It is more like a note to myself. I'll have to get
> debug dumps from someone with affected chip(s), and for that to work
> support for those chips has to be enabled in k10temp.

Ok, then, will take those patches as is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

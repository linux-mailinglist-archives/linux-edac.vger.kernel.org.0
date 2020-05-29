Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE521E7C47
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2LuL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2LuK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 May 2020 07:50:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D5C03E969;
        Fri, 29 May 2020 04:50:10 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f5e0065ddb5c3466bc22e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:65dd:b5c3:466b:c22e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2147D1EC034F;
        Fri, 29 May 2020 13:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590753009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8uVG8SSA7EoFL0uY2ymRckM3QLUfLiR58WqegFOFyS8=;
        b=B3M8BCT7Bj4c2FvAhaetyMK3iaJAYzYb1CAOH9yGxH4jYGkLa9TMbxoYdYKvBGNvQkaa8g
        9jMM9iTzXv5rIkjh6dEWij6fOAgWRSFuYZR5kAk7MMF2uWYUA3o4dV1JUVcAHt1jk9oSaU
        lOioPDeuztomIM2HDHCvSNLcnRPnAC0=
Date:   Fri, 29 May 2020 13:50:04 +0200
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
Subject: Re: edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
Message-ID: <20200529115004.GE9011@zn.tnic>
References: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
 <20200529093644.GC9011@zn.tnic>
 <c304a0b0-692a-0696-6750-05a3db6a4b42@web.de>
 <20200529094758.GD9011@zn.tnic>
 <fac5fdef-6148-38fb-1149-5bfc06969ac8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fac5fdef-6148-38fb-1149-5bfc06969ac8@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Which part of

	"Please refrain from "reviewing" EDAC patches!"

don't you understand?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4D3AAEA5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jun 2021 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFQIXg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Jun 2021 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFQIXf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Jun 2021 04:23:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DEEC061760;
        Thu, 17 Jun 2021 01:21:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0eb200ab657fc0ea7e4260.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b200:ab65:7fc0:ea7e:4260])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DBFB1EC0556;
        Thu, 17 Jun 2021 10:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623918086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p9KkfoMxQXHVpn5PWqJhxG6N2m4bA23fyu2hCz87bkc=;
        b=MtphHVOANg6LtS7S0gOt47DNm2PwKzgTbELvCzIF3EBJVD8T++yhUobH30A4tJMq5I+loj
        oeOmDta0pVA240jqgwjSgbdDOC9Jl2xiGynvIrEkLrCc1zXkdYFQr6ddLn94q7VE+BWbe6
        ryqLv/2QhuZLQep3VB4mtHc+Y3o8e1o=
Date:   Thu, 17 Jun 2021 10:21:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] edac: Convert list_for_each to entry variant
Message-ID: <YMsF+lGa/kCLvzRA@zn.tnic>
References: <1623740110-15764-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1623740110-15764-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 02:55:10PM +0800, Zou Wei wrote:
> convert list_for_each() to list_for_each_entry() where
> applicable.

That conversion is applicable to one more place in that file...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

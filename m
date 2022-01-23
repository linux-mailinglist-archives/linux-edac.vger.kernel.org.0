Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566394974EF
	for <lists+linux-edac@lfdr.de>; Sun, 23 Jan 2022 20:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiAWTTj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 23 Jan 2022 14:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiAWTTh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 23 Jan 2022 14:19:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666A3C06173B;
        Sun, 23 Jan 2022 11:19:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EC531EC0104;
        Sun, 23 Jan 2022 20:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642965570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2+PHYFr09/Oh98ANEvj4yzndpd/gXrp2phgkiFnwhAI=;
        b=oi7xsbvCjsTm3P4q3KKiqS4XGVN4MlweB+FjapipuEY7ZEkWEBYokdu92Pq5KF68G8dKvY
        u9TV5M+ATfk98gaS27QfKEdyLlMfTDOI/A+xVDTwCR8Pa93/n5MWmE7ugjxxCXoOFiIONT
        R364vpbuIODRY3lb94LV2XLdbBExR+s=
Date:   Sun, 23 Jan 2022 20:19:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC: use proper list of struct attribute for
 attributes
Message-ID: <Ye2qPXZZEvK/b8jO@zn.tnic>
References: <20220104112401.1067148-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220104112401.1067148-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 04, 2022 at 12:24:00PM +0100, Greg Kroah-Hartman wrote:
> The edac sysfs code is doing some crazy casting of the list of
> attributes that is not necessary at all.  Instead, properly point to the
> correct attribute structure in the lists, which removes the need to cast
> anything and the code is now properly typesafe (as much as sysfs
> attribute logic is typesafe...)
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: do the same thing in edac_pci_sysfs.c
> 
>  drivers/edac/edac_device_sysfs.c | 28 ++++++++++++++--------------
>  drivers/edac/edac_pci_sysfs.c    | 24 ++++++++++++------------
>  2 files changed, 26 insertions(+), 26 deletions(-)

Both applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

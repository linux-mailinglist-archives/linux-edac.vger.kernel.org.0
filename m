Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11F1ECE5A
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jun 2020 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCL2Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jun 2020 07:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgFCL2Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Jun 2020 07:28:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E79CC08C5C0
        for <linux-edac@vger.kernel.org>; Wed,  3 Jun 2020 04:28:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b230065380e66e0b088b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:6538:e66:e0b0:88b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63C081EC011B;
        Wed,  3 Jun 2020 13:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591183701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+drPflWOll/Z4R0L6VCg+csB+HTbWWfKoVBP2h0CyuM=;
        b=khXYOKwlg1c1GyZWOTRKiB1hp0LrQWN/Dlvuc12k24kD0RQutJkfAo7U1kPLd0adSffpca
        fBFm1OvyFr7+N6kT2mMLrS8UtjtevWzHFXnE2zWT3rhESaEuexOxEpSA0vzEz8Of0mORgb
        UnZXijAyEW2//1LgoxXUES51+ynKkxA=
Date:   Wed, 3 Jun 2020 13:28:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     wata2ki <wata2ki@gmail.com>
Cc:     linux-edac@vger.kernel.org,
        Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
Subject: Re: [PATCH] EDAC/mc: Fix memory alignment calculation formula
Message-ID: <20200603112816.GC19711@zn.tnic>
References: <20200516162115.16545-1-wata2ki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200516162115.16545-1-wata2ki@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 17, 2020 at 01:21:15AM +0900, wata2ki wrote:
> From: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
> 
> During the development of the off-tree driver,

Wait, what?

Am I reading this correctly that you have an out-of-tree EDAC driver?

If so, why? Why not submit it upstream?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

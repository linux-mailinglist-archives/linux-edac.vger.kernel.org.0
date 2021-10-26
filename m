Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA943BB84
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhJZU2M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhJZU2L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Oct 2021 16:28:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0894C061570;
        Tue, 26 Oct 2021 13:25:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131c00b46b7e3e031d787a.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1c00:b46b:7e3e:31d:787a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1D71EC05D3;
        Tue, 26 Oct 2021 22:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635279945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WLlTpXinvh+EyZlgjO8NYvSEq+h4ilFLERK0QuXowpM=;
        b=fY5TQGh9fW9CS5tZKqmOaGPw2OGjBTKjSUz81MQogjLbxsxhVnx6EYX0lYCZIFK5HSSykU
        WQYxBGaIqluPJYPD2KdTo6Y3w/yyKlsp2G36dviCniCNSPe+KS/pqL26GVOIdTHLrZUjX5
        tjVRVBnh3PbwIPEfHr/5x0VeMfrQOgQ=
Date:   Tue, 26 Oct 2021 22:25:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
Message-ID: <YXhkS7Ow9bdXOXpb@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
 <YXfSGW1i5dLsiX84@zn.tnic>
 <00f4a0ab-f241-6674-f37f-623f3d9a8337@amd.com>
 <YXg3rIump+CAtgs6@zn.tnic>
 <73439c67-b7a3-e43d-511b-86f4a314fa29@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73439c67-b7a3-e43d-511b-86f4a314fa29@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 26, 2021 at 01:53:32PM -0500, Koralahalli Channabasappa, Smita wrote:
> Not a problem. I could have broken this down in the comments before
> coming up with this patch.

No worries - sometimes proposing the wrong thing even helps in deciding
faster what makes sense and what not. :-)

> I will make the necessary changes and set the valid bit in the next
> revision of the patch series.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

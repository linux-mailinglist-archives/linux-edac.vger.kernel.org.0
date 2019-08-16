Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67EF8FB56
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2019 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHPGq4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Aug 2019 02:46:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGq4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 16 Aug 2019 02:46:56 -0400
Received: from zn.tnic (p200300EC2F0A920041519BC41B2ACCA3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:4151:9bc4:1b2a:cca3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8504D1EC074B;
        Fri, 16 Aug 2019 08:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565938015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3ldeSatrRtTyNqO2P96WQqIXOHLJo+VWGZk+uXxJcII=;
        b=TyiSeb9Ph8Bz5VxBujWAble1erTVxtJ47aBU7iSykM8A/zC4bxLf4x3CjhS9oxFVSpcB0l
        jaNdSxcyJGnLVUrIh1rFHk3NssHUDPasBbY7fK83PIXTGHwLkONbomHwU8bVc6Inh89MB7
        2XTuni7eo4lee624rf1k4JDtBTjYcUE=
Date:   Fri, 16 Aug 2019 08:47:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] AMD64 EDAC fixes
Message-ID: <20190816064744.GE18980@zn.tnic>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190802144626.GD30661@zn.tnic>
 <SN6PR12MB263968E448E4CCD4C6856288F8AC0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263968E448E4CCD4C6856288F8AC0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 15, 2019 at 08:08:39PM +0000, Ghannam, Yazen wrote:
> Yes, I agree. I was planning to do a fix in a separate set. Is that
> okay? Or should I add it here?

If you have it, send it on, sure.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

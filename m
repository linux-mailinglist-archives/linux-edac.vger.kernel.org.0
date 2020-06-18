Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2F1FFAA9
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jun 2020 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgFRR46 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Jun 2020 13:56:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgFRR45 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 18 Jun 2020 13:56:57 -0400
Received: from zn.tnic (p200300ec2f0dcf0005555d042158ef9e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:cf00:555:5d04:2158:ef9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 567271EC0423;
        Thu, 18 Jun 2020 19:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592503015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Os6rGJV75bv5vqp4xjrJLJBcqG385J3PUiuwO40x2E4=;
        b=UHFAU6003Kp0gyj0sDh/DWcB828PeRMKcOHGpec2M8vfjSvDaxcHR/8fHRUOJujFtOcW6n
        t/Qi69ZxhrABRErUDXFPf690bJwiDAGuYTsIl43Z3szqzeFlzeyyJHOutjbGtZcXBWfej/
        enGtpEegcZ6mIscTKvW6OdHpOXoVO9s=
Date:   Thu, 18 Jun 2020 19:56:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Andersson <pipatron@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: User question about memory scrubbing
Message-ID: <20200618175646.GD27951@zn.tnic>
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 18, 2020 at 06:49:45PM +0200, Anders Andersson wrote:
> Hi! I realize that this is more of a developer-to-developer list, but
> I'm a hobbyist who recently bought my first system with ECC RAM
> (Opteron 6386 SE) and I can't get memory scrubbing to work. It's hard
> to find people who know anything about it.
> 
> Preliminary research led me to the EDAC documentation on
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-edac
> and in particular the "sdram_scrub_rate" file, but had no luck
> manipulating it.

Oh, you're manipulating it alright but there's a bug in reporting it.
Wanna test a patch?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

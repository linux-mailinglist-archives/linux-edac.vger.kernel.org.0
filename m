Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6E2482AD
	for <lists+linux-edac@lfdr.de>; Tue, 18 Aug 2020 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHRKMn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Aug 2020 06:12:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgHRKMn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Aug 2020 06:12:43 -0400
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B078D1EC0242;
        Tue, 18 Aug 2020 12:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597745561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MKT2E1oYlR0YKb4IeiRvZJA7wmTBh6Kl+He4UCrOyQY=;
        b=pHATl2szjiox7Cgv8z9qTteNJqRiEaOOQzlNxBF/mz+oZlfXS0MtSxpAm8hArxz/uXj0cB
        Qu7nPMN3L2i4GuA3FKn/WITvX2HyHkH2TByOQFZI3sXZAtCl+QYPrTFw+9r6mPxzh7MOVY
        MrqIcJc90y8i0fN+ka74iIoMepOfuVI=
Date:   Tue, 18 Aug 2020 12:13:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd: Remove struct
 smca_hwid.xec_bitmap
Message-ID: <20200818101334.GA31641@zn.tnic>
References: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
 <20200817093956.GC549@zn.tnic>
 <20200817151821.GA1095089@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817151821.GA1095089@yaz-nikka.amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 17, 2020 at 10:18:21AM -0500, Yazen Ghannam wrote:
> Yeah, I'm trying to keep "may" out of my vocabulary. :)

Hahha, you never know with hardware :-)

> I do. This check was added because I wasn't sure what to expect with
> this new architecural extension. But after a few product releases, it
> has been unnecessary. And I don't see a need for it with future systems.

Ok, will add that to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

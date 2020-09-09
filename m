Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031972626FB
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIIGBH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Sep 2020 02:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIGBE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Sep 2020 02:01:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A012AC061573;
        Tue,  8 Sep 2020 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r6fCejwG0iL+7qa2R9K1o31Ku9WHMAs55cEybInLu9E=; b=JF9xLeJ05bJ4buQmwRppivJZg7
        hFBS727vORj6a1zw4y4aYHspScHg5i4VntwFdoGCQYpCZL1OyicDHWHvHZoy/G6ncasFwH7y8OIRT
        ghAVAt9dGdjfCqdV95OoxVE0Zz6SI55zoXXitO29keTsBQBTpDig9Iu0X8XTlC6iDHAFZJxuJnoTK
        tjqCXcUncL8T+FRE/4KZ2aH+JcimPgSzCvgsFvC3WCeO9Es1spYOg8RSKXorg9wkFExMJNhOy8Iqs
        YPrurd+4pJsFbPkX/3L/Uehh7dhZdXSvA1KdPrvKcX6KT1ontnkgZDbwbY5pMVjb/4eYukLmLbm6q
        rzbwh/Xw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFt9x-0003xX-H6; Wed, 09 Sep 2020 06:00:45 +0000
Date:   Wed, 9 Sep 2020 07:00:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dkangude@cadence.com,
        yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        rrichter@marvell.com, james.morse@arm.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Message-ID: <20200909060045.GA13647@infradead.org>
References: <20200907061126.GA14999@infradead.org>
 <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 08, 2020 at 08:12:16PM -0700, Palmer Dabbelt wrote:
> I don't know enough about the block to know if the subtle difference in
> register names/offsets means.  They look properly jumbled up (ie, not just an
> offset), so maybe there's just different versions or that's the SiFive-specific
> part I had bouncing around my head?  Either way, it seems like one driver with
> some simple configuration could handle both of these -- either sticking the
> offsets in the DT (if they're going to be different everywhere) or by coming up
> with some version sort of thing (if there's a handful of these).

regmap can be used to handle non-uniform register layouts for the same
functionality.

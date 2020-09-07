Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B104825F30B
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgIGGLh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 02:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIGGLg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Sep 2020 02:11:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520BC061573;
        Sun,  6 Sep 2020 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qfcALgvFzZYc/TWT3h5fMbHKeWOPoZL7AoIZsE93hQo=; b=dn2D9TiXe1LDIDlV1gQsXwiTjX
        5dA9T1ojQpMSM5eJyXJPC+XIleTHAJp2xN8n4Vmxa+uPtaPXMLjwBNVaQlEc4JXjJ+AZXOTbktX1Q
        HEYagLu5mM5tpQz68LbkspH8Rl/+4maOP1z4/Q7lR2Trde+6AdiJJSb84ctKey68868Mi7iBdCdG8
        XSFe2xxB4SkRrx/qlOl1BPytAIMjYsImzjZ55XT9n4Q7Qw02TGYmMZNolsHpaXTDKr7iwPT1zlo1B
        FGHOTlcrCQzMIopOcac4bS0lxYWGpeF4jxoWAdkIomOlLbKDeQbqw7VDbXSRnT7qSTKTzADqQfwTq
        Sfv0OQoQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFANC-0003wC-UU; Mon, 07 Sep 2020 06:11:26 +0000
Date:   Mon, 7 Sep 2020 07:11:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        rrichter@marvell.com, james.morse@arm.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Message-ID: <20200907061126.GA14999@infradead.org>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
 <1599457679-8947-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599457679-8947-3-git-send-email-yash.shah@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 07, 2020 at 11:17:58AM +0530, Yash Shah wrote:
> Add a driver to manage the Cadence DDR controller present on SiFive SoCs
> At present the driver manages the EDAC feature of the DDR controller.
> Additional features may be added to the driver in future to control
> other aspects of the DDR controller.

So if this is a generic(ish) Cadence IP block shouldn't it be named
Cadence and made generic?  Or is the frontend somehow SiFive specific?

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE43C91CDC
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHSGIU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 02:08:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHSGIU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Aug 2019 02:08:20 -0400
Received: from zn.tnic (p200300EC2F04B700DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29AD51EC072D;
        Mon, 19 Aug 2019 08:08:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566194899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MMEqOH0+FlQ5k6rfnVWw/505PbR2ZwBwzOxGbP7W7ug=;
        b=epVl8hyDU59xc4Vq6q6F/+cx8Go92rnrjQ5u5H6XsilcL67UIn3Mpusa9gD8IOP00CHMkl
        JlBHKrSVaclPsjc3i74rRQ7oIXOxv4RnR1GKhqoI9RX9ihYpZ5f899I34U97GJbGlgeein
        vjULeVApAUFfp4aeZq5HE9wG9EoWaho=
Date:   Mon, 19 Aug 2019 08:09:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190819060904.GA4841@zn.tnic>
References: <20190818082935.14869-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190818082935.14869-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:
> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way

That changed recently so I guess we can do the per-IP block driver after
all, if people would still prefer it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

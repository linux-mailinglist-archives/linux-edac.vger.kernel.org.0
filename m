Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1010AC28F
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404916AbfIFWdF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 18:33:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36209 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfIFWdE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Sep 2019 18:33:04 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so16400757iof.3
        for <linux-edac@vger.kernel.org>; Fri, 06 Sep 2019 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YRsccmFbDQQjungCxi/rfzbQ2IZD8msr9cyayv1Eid4=;
        b=ZcgTOH2jNyuEvpZxi4ZVGo6r3CKvNsWrq2VWnLanEds/0AAZvZeKuFE9gYXsFIJ54u
         /sdDa9wCmYdQds2kybVvEZWLXpGtnj39ehpMP/91t+kvUNF3jhgq52a6wMgBAmb15KwO
         f0xROPrHflfSto6hFc1BZA9BvJm/2IgZClYWmD4+9mXI24yq5vVFaNPEBeSQwhHoL123
         yo5GbF2hbmfH+ia7/IL/DA2cxU4IdYn/tOkSi+qCJEXECxifR8uhx9t+Q4yR6YmNLgr5
         cRj3i/6wOlL1Nb1Pb/FGYUPiAPU3u5Bo5MIvhQqNFAdrgMwcOX2qoz0JEnJfTYJDcHKC
         bI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YRsccmFbDQQjungCxi/rfzbQ2IZD8msr9cyayv1Eid4=;
        b=M9jtnW0dWGOAF4D9vOHQcppkN5CTsx12ZBnUnh8FbHqXodqNfN/DugPHZPN+khCQy8
         kArrehC2TnGBEFh3IfQVETpAuvhe2ZpoD6fPQbgYOKDc0s45C6g9AgaESeXmgjm+3Msq
         LVMThZbrLVvqiyullg00MdisHyEpF8ovUBtRmv9uwY92R4Q0taYJH/vgMwXwQBBrd/RZ
         0NTfp1Wq8Pvs3qT95qblPpuyCGiftW7qxZJJllICCy4qlFvai4ELuqIQBwzPyjRmiON3
         2NBajAnGYzHbxinQp4c1SNJxh3k4WvNg9ho1+kTL+8d+JLf46kml/7eyMlucA/YxAxSo
         4DxA==
X-Gm-Message-State: APjAAAVwFL3WBtcnbyL5VRYjc3RVdszDCLavSxKvHQR3kwRhAy1P6KIH
        ZmsmSCXjRyUfqkQKxSheSI6VV1/zjFU=
X-Google-Smtp-Source: APXvYqyxdUW/2++hNyntiZhHPRTa5wOzs/5LZb+eIJajhIYFEi8CvuN3riIJHG7wc9yCykPSpHpnIg==
X-Received: by 2002:a6b:ee17:: with SMTP id i23mr12722648ioh.168.1567809184139;
        Fri, 06 Sep 2019 15:33:04 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id u6sm4457439iop.18.2019.09.06.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:33:03 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:33:02 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Borislav Petkov <bp@alien8.de>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <20190819062619.GA20211@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1909061527510.6292@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 19 Aug 2019, Christoph Hellwig wrote:

> On Mon, Aug 19, 2019 at 08:09:04AM +0200, Borislav Petkov wrote:
> > On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:
> > > The sifive_l2_cache.c is in no way related to RISC-V architecture
> > > memory management.  It is a little stub driver working around the fact
> > > that the EDAC maintainers prefer their drivers to be structured in a
> > > certain way
> > 
> > That changed recently so I guess we can do the per-IP block driver after
> > all, if people would still prefer it.
> 
> That would seem like the best idea.  But I don't really know this code
> well enough myself, and I really need to get this code out of the
> forced on RISC-V codebase as some SOCs I'm working with simply don't
> have the memory for it..

If that's your primary concern, then in the short term, how about just 
sending a single-line patch to the arch/riscv/mm Makefile to skip building 
it if !CONFIG_SOC_SIFIVE?  Assuming, that is, you won't be enabling EDAC 
support for those low-end SoCs.  Then you won't need to get the ack 
from the EDAC folks in the short term.  

Then a patch to make the SiFive platform EDAC driver build contingent on 
CONFIG_SOC_SIFIVE could be sent separately.


- Paul

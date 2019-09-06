Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10B5AC29C
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbfIFWgN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 18:36:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40459 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfIFWgM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Sep 2019 18:36:12 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so16345688iof.7
        for <linux-edac@vger.kernel.org>; Fri, 06 Sep 2019 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/OtDkC3pdZM2krctzGQ+0mwUr2A4Fs4btQ+iI6by6RE=;
        b=U4aVJDu5VXkgoIzNl4rkJ0nf2rR1BtS2JRC7srMfDmAux89pa3jMXCPQ+73gGP4pQo
         Fb6D2ltlQysy5TqKEABHdV+ayc4GTots+ylmlZ8aSR88vtlI4wIP+51mF7gDrjl1I3vb
         4O5WhDwC76LXCOkjNL+0FQRq7q8YIQVRKzBdI/ORwFTDo5PgD3CfM2FFCmGCjBE6Iz3W
         hZFSoXNEQMqtrToRHblAMK5u0Rd++k65C3zVKL8whgA0qN9mPt6L6fWeyb4MQ1SX/2zw
         w3/cEkDJ7QJAXrSsjya9DcI/Lc/UotopuyJ4alzf+dl0dV8OxKidh9YYMgKS6zkIR/cS
         IRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/OtDkC3pdZM2krctzGQ+0mwUr2A4Fs4btQ+iI6by6RE=;
        b=HfWamYHaeJ2cvNjShdwyvGJIOamZ4cNWJjAAYJWElYE2FRKXwgP2hhn3osvOZvWD21
         2X+WGx2kq7Nj4kUGK/bb5usw51nRgHEpivaxaweYW0yWx/E70Kg2EWIIV1KA3+HP+02a
         T3BBIcySSUdY0f1igb4SjAE7b9dmfh7OGwN5SzkVzsmwWwNeVf6/6KeLlIvji+Gufcx4
         9IeRqtXFq5ShP24DMdqiGsAxt7NUtojH4JXCntJuhZ+XwG23oazXYFnzXoZVQxCmDMpc
         X5P2c2W9kjVr8kUyMykLDaT0KHXMaiBtEG/Rv1jL+t/cTYyXW1KJhLdzUDTNJbym8YPA
         Uqzw==
X-Gm-Message-State: APjAAAUCtuMlUKWwT3sMv06Hj/hrZxhLqr6aEJs/7AzqJbnyMKCmoA3F
        S+CVROjZs4tvKmGNZyXGfm/UPA==
X-Google-Smtp-Source: APXvYqz4MaleudQolCZG/PjbQC417j+Ug7KgFVxamxGmKjA3pdAN9qsIdwzmJJTiIGhfUx+hi+xiBA==
X-Received: by 2002:a02:c546:: with SMTP id g6mr12808435jaj.59.1567809372001;
        Fri, 06 Sep 2019 15:36:12 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id d20sm6201253ioh.2.2019.09.06.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:36:11 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:36:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     palmer@sifive.com, bp@alien8.de, mchehab@kernel.org,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909061533260.6292@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de> <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

One other comment on this patch:

On Fri, 6 Sep 2019, Paul Walmsley wrote:

> On Sun, 18 Aug 2019, Christoph Hellwig wrote:
>
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 200c04ce5b0e..9241b3e7a050 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
> >  
> >  config EDAC_SIFIVE
> >  	bool "Sifive platform EDAC driver"
> > -	depends on EDAC=y && RISCV
> > +	depends on EDAC=y && SIFIVE_L2

Since the guidance from the EDAC maintainers is that this driver is to be 
a platform driver -- which would, for example, also include EDAC support for 
other IP blocks (e.g., DRAM controllers) on SiFive SoCs -- this should 
depend on SOC_SIFIVE, not SIFIVE_L2.


- Paul

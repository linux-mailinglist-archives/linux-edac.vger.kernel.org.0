Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB55526A8B1
	for <lists+linux-edac@lfdr.de>; Tue, 15 Sep 2020 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIOPXH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Sep 2020 11:23:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38778 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgIOPW1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Sep 2020 11:22:27 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so3369795ilp.5;
        Tue, 15 Sep 2020 08:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2dmfNBb0or2XBWPH7M/N/gQr8odxPSG4GRXc89xeEQs=;
        b=kI+tqO4rnfSfUIXlyg7ib6CIseb2RIx2ut26vxkA3hKLpa2S2hypmrDqM6XHFDUMRE
         O2sDvQ1jDsXRbOrXhk5l0jQpk4m4jFB/6x97e5VafkeHtQ7DY89eM165n3YljzLGLvOa
         zO5lVLmojGf17VAFi9QAoPX0EmEgrlWZoW5oOqecyZWtKoXR0BBqmiPs5gAFlZVeNDg7
         kPQMD6T0b3/yvJczBIYz2WGagjRdIqieFzldPVE7sdkKdYETLhavLwOy7NEUy1Gil8YP
         /kHqofIleSisEZ4OZccuA2jMmV1nJ0kQS0D58QzFkOBjas38ovaNbZfhnh8qpLAWkOS7
         BCOQ==
X-Gm-Message-State: AOAM531YScRqoiH/5jwLgssje2SnUvdgtQoVzGZ+fzGFs6NSEUbBrLu+
        croyctrNGgen3bkFdRZpog==
X-Google-Smtp-Source: ABdhPJzarGxOa8101phpgLhMEl8zzSnfyDc9QvxX1EgyRjavIVLGiApIp7im8HIM665ERMPXyFrw8A==
X-Received: by 2002:a92:9f53:: with SMTP id u80mr16938322ili.42.1600183325322;
        Tue, 15 Sep 2020 08:22:05 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b8sm7756889ioa.33.2020.09.15.08.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:22:04 -0700 (PDT)
Received: (nullmailer pid 1970179 invoked by uid 1000);
        Tue, 15 Sep 2020 15:22:01 -0000
Date:   Tue, 15 Sep 2020 09:22:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, aou@eecs.berkeley.edu,
        james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 0/3] SiFive DDR controller and EDAC support
Message-ID: <20200915152201.GA1940827@bogus>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 07, 2020 at 11:17:56AM +0530, Yash Shah wrote:
> The series add supports for SiFive DDR controller driver. This driver
> is use to manage the Cadence DDR controller present in SiFive SoCs.
> Currently it manages only the EDAC feature of the DDR controller.
> The series also adds Memory controller EDAC support for SiFive platform.
> It register for notifier event from SiFive DDR controller driver.

This is an odd split and notifiers aren't a great interface. Why not 
just combine these? Is there some other DDR controller functionality 
planned for the driver? 

FYI, highbank_mc_edac.c is also a Cadence controller. IIRC, the register 
layout changes for every customer/design.

Rob

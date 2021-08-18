Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5F3F0927
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHRQeD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Aug 2021 12:34:03 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36698 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHRQeD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Aug 2021 12:34:03 -0400
Received: by mail-oi1-f170.google.com with SMTP id bd1so4165434oib.3;
        Wed, 18 Aug 2021 09:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rVvsI0Xv1d0KYUJHwLCP2+hlZA1OJu/pLbegVr3lseM=;
        b=puYhaY5SearGQuUdNvkRV/hydoV2eoCL25Bli8QAWzN6fzwEiRlpUBGIe2CxtkXPDt
         ueSSzlE+JpyiyDVcRutdND3ASLVFSsk6Gv7ij4RztAvmUzp1SXPfx5caAfrJ0iAMxyWn
         YkyZ2qW+N6yQCPVd+2dMzgCReSZYVuZ3WQgy9/RGAQYQWUwwSbGs6x3n7ad1oc3OaYmD
         +UbJ0TrUd+slFPGlaGvKp5A1H0WUCV4wV/1B29M4UE6ab74yLDQLm5zs6RwQAl7kGRcx
         qRBwYqtIymJ6NrTYT6yrKH2tFCtESa6W9AKiQl1x8kdCDaHnJwGAHVs/eyjUu72suO0g
         8T0Q==
X-Gm-Message-State: AOAM532qCLIcFziJwpAL6EFD85u2tmaRfG+iauCZ4j9qW/ScISCLD6Um
        kXCFWiTNKIxltpKdWHfR0Q==
X-Google-Smtp-Source: ABdhPJxNY4w/KPNUjuR1sW0fQOhWU9TBObGNk6n0bEPJ6RdxCp2Vg5AgNS8Cq1Qc/ZRFZhp0tuxv8Q==
X-Received: by 2002:a54:4614:: with SMTP id p20mr7812388oip.136.1629304407995;
        Wed, 18 Aug 2021 09:33:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm99998otl.32.2021.08.18.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:33:27 -0700 (PDT)
Received: (nullmailer pid 2723574 invoked by uid 1000);
        Wed, 18 Aug 2021 16:33:26 -0000
Date:   Wed, 18 Aug 2021 11:33:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: EDAC/armada_xp: include dt-bindings
Message-ID: <YR02VkXGgsF7W7OU@robh.at.kernel.org>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
 <20210817093807.59531-2-krzysztof.kozlowski@canonical.com>
 <0f5ae210aab8ef5e00172928c341c0e6c88790a2.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f5ae210aab8ef5e00172928c341c0e6c88790a2.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 17, 2021 at 12:50:22PM +0200, Jan Lübbe wrote:
> On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
> > Include dt-bindings for Marvell Armada XP SDRAM and L2 cache ECC in the
> > EDAC-ARMADA entry.
> 
> The L2 cache binding is already described in
> Documentation/devicetree/bindings/arm/l2c2x0.yaml, so this is only for the
> SDRAM.

Fixed up and applied.

Rob

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13B25FE2EB
	for <lists+linux-edac@lfdr.de>; Thu, 13 Oct 2022 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJMTsP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Oct 2022 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJMTsO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Oct 2022 15:48:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB7118C42B
        for <linux-edac@vger.kernel.org>; Thu, 13 Oct 2022 12:48:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq16so2935774pjb.2
        for <linux-edac@vger.kernel.org>; Thu, 13 Oct 2022 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PKyqDLhwmXPlUdhrOFFEBt/uab4gB4wdiZD+rRvzv0=;
        b=oa+d1i4Vns0R2oqrhpWlUSOtEDshMIWWkCeJBhsy5zSAJa/Q+G8KdmDwnS/jYVN4qB
         ZQzOLvst2cLa2gX8HGIK9Qnb1iWAVGDZ3KthifDUdi+rC/6pq/LUCbBGMsbc8dK/abW/
         +BXmZ9CGp2VtztmjrE4oulZM9h89r6HQBLQpbsXfQyCzosPl3RMuRseKvvAxu6JJS2p5
         4E/Mu2VnAVxRaqybBdv6Bxs2rJ1clawxOdBri3n2JzNOlQxMfdPnMckK8o51dp7pngZR
         VIfVyUx0ot29VNgMASBf5w2sOsRfUY6lRv1HmFB0D+E0xJn/97dgWzCgSQccQnAatk6s
         kQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PKyqDLhwmXPlUdhrOFFEBt/uab4gB4wdiZD+rRvzv0=;
        b=tVRjDRn77XfJTfhKgm6F0Z23CXtJXOvSeVF3R9P7QZGlGVya6OQc+2za13nuKSYOx/
         w86W2H6pP2TCGDx7VkgrlEZjw7r2Rd9OJwmwhvfMFvnF3n2B6NSmwLioKkQWADou5KHW
         BYJAus2nq2uBshLTSXoCVLu7U3kVaVQ8RMSVnNqPW6rjznTH3tfYjDs7S6u7GlxShTlv
         sfG4vG4SuhycbWh6LNr8yvC2ilFYrLRPBGuRT7i1nFA3oncYHwmIx0Ba/P/ANFv2UL2h
         NJiv2zchTGdmMM1QOektfDto8+ltyVi6qdi+tAtPdG2Wm3VX6rrG7g9n1wXIXAZYbmJb
         /n8w==
X-Gm-Message-State: ACrzQf1qcMiED/yrqYVyihpOuD12f7RXtqWc3XaFhuu9YXI7+ax7ugET
        x/t1UtaCTAURMNbEbvNTrp+ylw==
X-Google-Smtp-Source: AMsMyM7rs4+Xvr4VuFSGLeN5dBixcWvSAhd5HBRs9TW0Yo62t4fsHya9i5qhDfSFJds2UqH0yoWvQQ==
X-Received: by 2002:a17:90b:38cd:b0:20d:8852:89f3 with SMTP id nn13-20020a17090b38cd00b0020d885289f3mr11945671pjb.41.1665690491520;
        Thu, 13 Oct 2022 12:48:11 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q10-20020a631f4a000000b0045fcfde8263sm93243pgm.53.2022.10.13.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:48:11 -0700 (PDT)
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
Subject: Re: [PATCH v5 0/7] Use composable cache instead of L2 cache
Message-Id: <166569033634.14806.7775220553152326118.b4-ty@rivosinc.com>
Date:   Thu, 13 Oct 2022 12:45:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     bp@alien8.de, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>, greentime.hu@sifive.com,
        Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-edac@vger.kernel.org, ben.dooks@sifive.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 13 Sep 2022 06:18:10 +0000, Zong Li wrote:
> Since composable cache may be L3 cache if private L2 cache exists, we
> should use its original name "composable cache" to prevent confusion.
> 
> This patchset contains the modification which is related to ccache, such
> as DT binding and EDAC driver.
> 
> The DT binding is based on top of Conor's patch, it has got ready for
> merging, and it looks that it would be taken into the next few 6.0-rc
> version. If there is any change, the next version of this series will be
> posted as well.
> https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
      https://git.kernel.org/palmer/c/44dce4b084f8
[2/7] soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
      https://git.kernel.org/palmer/c/ca120a79cf5a
[3/7] soc: sifive: ccache: determine the cache level from dts
      https://git.kernel.org/palmer/c/95f196f3212b
[4/7] soc: sifive: ccache: reduce printing on init
      https://git.kernel.org/palmer/c/3fb787e5bad5
[5/7] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
      https://git.kernel.org/palmer/c/696ab9bda22a
[6/7] soc: sifive: ccache: define the macro for the register shifts
      https://git.kernel.org/palmer/c/afc7a5834f0d
[7/7] riscv: Add cache information in AUX vector
      https://git.kernel.org/palmer/c/da29dbcda49d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

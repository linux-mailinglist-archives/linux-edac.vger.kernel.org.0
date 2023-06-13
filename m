Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA072DE58
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjFMJzo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbjFMJzk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 05:55:40 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3AE3;
        Tue, 13 Jun 2023 02:55:39 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-78a3e1ed1deso342144241.1;
        Tue, 13 Jun 2023 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686650139; x=1689242139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwWyCUDuegx+tvkvTGStT67ElUFA4N+9n715czI5oMM=;
        b=EFOAAGfykMNiEdEIHAfYE+irtvjkVom+OCnYLYU3kU0Rke9e1gCAxYxpvkxgFfDTLq
         /IGjpl7MZuDj83JotVbsEk/YqixsvEiYQi9bAp5n+JdxO9Gan3tNXKEjF8mziH+PnJOn
         BmpvoPMpX+6oz9ORNEtky4ww3U8A5SZcXqmNrrEhtttLMzWwv0QhxCEZ7OgZ+ev2oBvi
         kOCmX5nZHqiY1dNRMiAX0ahKpTUrN9Mw65Wz8vfmCnilGw1vLLBSlw8MUU4u2JlMWwAP
         sivKbPprB2Nuk9rdmuuNeg6dQhUREKl2Kq59cBj7z1/ZpHtczZGoI8qP4L72MB6/b7wd
         z8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650139; x=1689242139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwWyCUDuegx+tvkvTGStT67ElUFA4N+9n715czI5oMM=;
        b=aefybr+O8DXwHvJpRXR8mZoZsLw5YfRYVleiW+Vn3LNs8rE5awNXi1+IMTuJx2HUE3
         V726KFdmIVT96pr6DEBXBi21YAhlCpJyy5F1PLAxZAFlMiWCNecKd39j5t98BIMhJWaz
         7nzEhmn6+VBSi0mgmM8hl+EvajQA5mPAS3bEyy7X2+Wjr9Ari5yBtTrUwcbxXF3/6pJq
         kJ95oSljMbJfNe4bOPht5qhGivCXvEsuSazMLvQRAQK3H5bk9EAM14WEQr4XQES55jVu
         GdR7eKmY3yPgmPWqJ8931Gx8GdYAtRPAiVLMefFV8cERPx8gUSzTJIqLm/jl5q6b4un5
         26mA==
X-Gm-Message-State: AC+VfDyjZWrkw64HiOnkeZDb6p89qRzMy0kRbbFsAUDVZBcB/0iQ4VQR
        jrjoEFTutNYbc0GDI5kNmHOPeapyTTrPYmZqjpOlNFqxFRg=
X-Google-Smtp-Source: ACHHUZ7e9IsqIAz0PgLSkxZe5wg7yRy8uMMFUo1OILtylLbe/RXl7LMH2ceasVjVOwYCrnYhfuIfG6I7+3mrqQZSYJg=
X-Received: by 2002:a67:b904:0:b0:43b:3978:2434 with SMTP id
 q4-20020a67b904000000b0043b39782434mr4872625vsn.22.1686650138870; Tue, 13 Jun
 2023 02:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230111093245.318745-1-milkfafa@gmail.com> <20230111093245.318745-2-milkfafa@gmail.com>
 <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local> <38c30778-9526-cba6-4ddb-00bcefeb5647@linaro.org>
 <20230612120107.GFZIcJA3zktkiyTS2+@fat_crate.local> <99795947-0584-df42-a28a-aa89d7e21c7e@linaro.org>
 <20230612123925.GGZIcR/dUrcu03z6V+@fat_crate.local> <e0171cb6-54e7-41bd-4b08-fa667fe58ff4@linaro.org>
 <20230612131649.GHZIcawTKBMIQpFD6I@fat_crate.local>
In-Reply-To: <20230612131649.GHZIcawTKBMIQpFD6I@fat_crate.local>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Tue, 13 Jun 2023 17:55:27 +0800
Message-ID: <CADnNmFqhNKoV5EfaiMSo9yz-hTaTm+0pGUJyFNH_V8pNVEU36w@mail.gmail.com>
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory controller
To:     Borislav Petkov <bp@alien8.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, tony.luck@intel.com,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, rric@kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        CS20 KWLiu <KWLIU@nuvoton.com>, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Marvin,
> Please route the DTS (1/3) via Nuvoton SoC tree.

OK, will route the DTS via Nuvoton SoC tree.
Thanks, Krzysztof!

> Patches 2 and 3 queued for 6.5.
Thanks, Boris!

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED5650B51
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiLSMUB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 07:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiLSMT7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 07:19:59 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF0E6F;
        Mon, 19 Dec 2022 04:19:59 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id b189so8432769vsc.10;
        Mon, 19 Dec 2022 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UtXTFZHf3aVGJpHVGI6rIuUunhrX9hgMZRutlbE5Png=;
        b=O1gbRQt3cPsc+vLtAct02ZrycIj1Nd6vmA6YUL4xt2OI7fQ6sMP4wUicxiKz8snkDL
         5pMW7lb5xOIIUNb2Xwj6eKJNIYBw9E6dyBFyp5dNCc5DFamMR2ILIyNSBCT7L5NCUyrl
         pRvDkudWDbevlDu4SfqsZgg8QElQ5hAPa87Tanx8FjpKAn2mosmd92enxvZZQ71pkgbx
         EpBDMFzHAWs5yGWYeK5hZlLIZJHR9PQ4IlDPW55mIEB3qgcx/E12n71Uy07W/Oym5Q45
         8hHZdznKLfBS47IRp0hfuMnpxPe+ZdmBnzqGHzbFDqf7sxTJSQ6e29zTA1pXL2MnObsV
         apsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtXTFZHf3aVGJpHVGI6rIuUunhrX9hgMZRutlbE5Png=;
        b=yyqZ4ysLd1vv+xjrtYdq5TvjZYrZZic+ZThBMM1pe9amHZ7YTLA1rdjizYXjUPvAw4
         TWY+9t0aR6Tf3pJSqnziyt3Z8oPJiSYkI/88uOKsrrNjvsSUlE83WZ20qNSeePeQrAKn
         YBDSmJZp2zeuqFdXvoImQ5vqm8krQUXCuOrRVNZfF0vb5RHdAycSncbhuAIGiG83atM3
         mrzKc+FW2LsP64phd9s/7c7I1ZaDhECC3UXugot6U2agUWYC3n36kxQI3dskBtgSSWsb
         tgiV9dc7xFtMp2Y7MkSM4ajZMKxrRA2wVx+Wc6yxu9L/W9epnupCKkGcYJA/STGquNIS
         U7vA==
X-Gm-Message-State: ANoB5pnpgDk0xvI1IPbAqyMpstrqR7rPV9QcMrsCSJsloQjADsqDuglr
        F6a8knrYWHboaK5OO6slIPY3gZdfpjNtgYfA+e8=
X-Google-Smtp-Source: AA0mqf5DhLkwiNMBaDlDxDf+qy1MFvHuI3nDyO7ibi4lc+8FjHFGoGf5BhxiNBACf0Z4zFYwrJCELfs0+n1tzPaL3+Q=
X-Received: by 2002:a05:6102:3a6f:b0:3b1:3231:ac9e with SMTP id
 bf15-20020a0561023a6f00b003b13231ac9emr14893922vsb.50.1671452398212; Mon, 19
 Dec 2022 04:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20221216073141.3289309-1-milkfafa@gmail.com> <20221216073141.3289309-2-milkfafa@gmail.com>
 <b861f167-c22b-7152-c273-47dfab54fe74@linaro.org>
In-Reply-To: <b861f167-c22b-7152-c273-47dfab54fe74@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 19 Dec 2022 20:19:47 +0800
Message-ID: <CADnNmFob+WsQFr+1EffGjP5ZVgKRutHyYoNLQkL85xNyraRAFA@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] Arm: dts: nuvoton: Add node for NPCM memory controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Krzysztof,

> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>
> It's "ARM:"

Will correct the subject prefixes in next patch. Thanks for the review.

Regards,
Marvin

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150D6E58E6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDRF7h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 01:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDRF7Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 01:59:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957955BA
        for <linux-edac@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso18605531fa.2
        for <linux-edac@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=B/lJxYxd9QgPHdTz8Y94+SQwigHwPQz1MSY0HBGE49jeKpZvQ5ridodaJ1/hg5dYTg
         xfm1UctNbPOooHeryL4EpFSpzLbpfIM/1AP6IiE/eAQ2XC+jiAPE4sjVq/0OLp+s5H64
         OPszLw7mQaJ1PqKU00ScUiZOb3Ks0WeXpBGa5YCNLjOyLXsRt33eVOV3J7/7jSzM1Fi3
         /RpCf1VKsRTVD/tqHSDxBWAwYQ/D3zBjMwphUFrVmu8iFcvUlk1YDipJso9tURLsGQAs
         Kxkqmj8wx1BzA1Zw3ty0py3y/B5zl4OJTEDWjPXGFVRp+Onsg5ZfmKZ52/USaH6DILFS
         M1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=IK2YmNzB51Eie1cW1UbCT7DC2Vi8fjjk6AZ7AK8bay64OT68hf3/T8in39oP4QVQ6d
         xS3PnqmFXEN/qmuBD3Bu4Yq0P6vBmc7SumAhWru8cN1dbfiTkpBcVxka4gJZd4YMiaAN
         dVLUpnCaC30J4p0d9SYJ/7pTrwOQ+IAqO6+1+aFDN8NoqLRJ+Hzg3D1E89Woa3tS/fVN
         KuvTv1sXfh0HC17c+4qXYS3NzRscxGTQ3qHfSzIS09Eua+gtEAeebCaqcZQ++3g1Ssqn
         kO8kBKas2DZ3MRgFchSdVu3qD7yf0aTIX219aFdGgv/HyYI/GCQrDTnAiyzn+TmwS0GF
         s1iA==
X-Gm-Message-State: AAQBX9c+nmU7P2usVADjVgg0jLAs9muh5QH/6wYDPLbj25un9kdemtat
        0Avd94A3dIxx7872fH0oC5yY52S+Q21eXbkHUSY=
X-Google-Smtp-Source: AKy350YRsUSKQ0+i58Lzun7WtY7IrRwSkm+DWIi2JdfS71rVYYWUT2OQ/a/Q5PRWIBazn3AQLm2dWBYGVxBajLvvRoE=
X-Received: by 2002:a05:6512:96b:b0:4e8:4b7a:6b73 with SMTP id
 v11-20020a056512096b00b004e84b7a6b73mr2935594lft.4.1681797550844; Mon, 17 Apr
 2023 22:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:2681:0:b0:1b6:840f:9075 with HTTP; Mon, 17 Apr 2023
 22:59:10 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame1992@gmail.com>
Date:   Mon, 17 Apr 2023 22:59:10 -0700
Message-ID: <CADUz=agNY633M0qMXMnAP3Ms7-3rKuWtAZGCOQZKeYpCdBxT_w@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame

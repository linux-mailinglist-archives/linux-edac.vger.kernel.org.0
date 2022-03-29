Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8837F4EB5F2
	for <lists+linux-edac@lfdr.de>; Wed, 30 Mar 2022 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiC2Wbg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Mar 2022 18:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiC2Wbf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 29 Mar 2022 18:31:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6B6A056
        for <linux-edac@vger.kernel.org>; Tue, 29 Mar 2022 15:29:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r7so11185658wmq.2
        for <linux-edac@vger.kernel.org>; Tue, 29 Mar 2022 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=YoRKYUJpcbMiuWmfkejsvgBLFfO+qGcTCNYSaOtTpC2aP/g+iP8HrGzaHML6olJl9N
         irRx7dajF5K8Cu/0ezdwN8WxD/QG0PuJufT4VxZbE6Af2RPsqS8kyRHNUzQzF+cDizvZ
         c0n3Q+A7DU1DRRhaAThFwRv0JJIvIR5NFhbmQIfwyh9OG+2FiVg39Xtuh2yNDDaE2G/E
         3Te4TfVKf1hdnuNCnSlvmIRzPDPKMxhYhyGFzn2xypRQ2dXADA4vBd7GuLtbdDOls+TR
         tCnTwSO8frplthBtD0cDpQjfgjZZ5GeAOGvCgj7qArjx47JWZCgUunx3fxCRb7HagG1D
         FLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=yV3fLHJYjAOZ5R2MePO8bTox/DtOHHZ8rc9JFeTYbQmHg9+h/Ng1W9H3khRoCwlWUc
         U5cipftQDOW9SpD6+/jiMtKJ6TcmiK/t68FPyONbNVdYF/pmfueuwi7QELAQd6NdI/fy
         jJcU+JVfV8KeSFCdEOm8pQVMuBySBjuN8Iw3HR0c/IUghIXUcMxlE46oK4mcALx/bbbA
         LnMFK4MOYVLKaIdZi4AxbsTE6xbd5UFeAA85y5EVPtAJgNK0TGHW2SjJj2+UzgpZFxmK
         VT6bn1TchZz6MokW5tgX28lKJv/q8Wg/QLBjCHIqSJxshDH+22hRreVb3qTrK9HXy+JE
         DfJQ==
X-Gm-Message-State: AOAM532YXX2bKQ/bz5gbppfgQb8mV2FCLd4wzsh6tKh9uJLvaWFoP/zO
        a/3V7jFiq3sKq9Ovn+i/iPniffkJ/iA3gQosQ9/u+w==
X-Google-Smtp-Source: ABdhPJwOecY3ArKz90K/082i5z9ade94+ryjx8r+Ep3tw6eeJZADuoGoPk62JPAoMmGEsLRZLkTcgA==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr1614781wmc.5.1648592991090;
        Tue, 29 Mar 2022 15:29:51 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b00203fbd39059sm16005026wru.42.2022.03.29.15.29.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:50 -0700 (PDT)
Message-ID: <6243885e.1c69fb81.4d4fe.f2d8@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:40 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.

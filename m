Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD884D7248
	for <lists+linux-edac@lfdr.de>; Sun, 13 Mar 2022 04:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiCMDTX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 12 Mar 2022 22:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDTW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 12 Mar 2022 22:19:22 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9AF63
        for <linux-edac@vger.kernel.org>; Sat, 12 Mar 2022 19:18:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c192so7372128wma.4
        for <linux-edac@vger.kernel.org>; Sat, 12 Mar 2022 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=JLg3nU7wGdJkGjp7YEL7Hgi4TmY3sL/Z7L6yPsZDvU5MRe8Cf5gnIT4FPN3BHcq/O2
         GZ9/vIkDEHkuOjLrX4ggYl0RuSMx1NdzhZpaK0y9+2550gNzEaMJTrutTySRfWNNVVfh
         rsciS9fTnVUjBZJ/2s4cEivNm1Gbrnr/tom5Hx8m8PdF7lqqs15pqqehJ8ziBShm1Snd
         ObXRpbgHdxh3fyB9vrZ9o4crUVIQ1tG0mBf4EwYI29q9i1Bq5MUZNcGD88+F07KYkrIt
         s2540hZdFHqKTanna7fJsfEglYhqe/d3EvZctmPuit6QkHHCB84e32KQNlQqaJT2ojPq
         XzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=SIZw2J4xm2wiE39Yc8wp7ysYANFkIDBVfM0gRz6QlyDeVVSEkBFZoYDqjlRAthHFgt
         q1mO3x3o/Io3wT5FvwYtMlo3nUnw0Gs9HuRun2QoIdIIXGq1nqGaGDmyHdptzfZ2UQKj
         4LYulL9KoDId7673LtGHBkvMrpyP6fZ+ssuk6DDlFdBcE+oXT54K/JOhPH7Yxhv5sWjD
         4KHvYe8yCchxWG7mVYWXx5Nm8CW0GijerCDYrjJYKhc9yJpNVpVfH8hEj73CczBVlI8p
         jKYX4Y7ECOxioa9N7cBGUQvoQUlZfq2plMUgmSW80tx1kcS4SlULVN9p/u+yRv85RCVc
         L3Eg==
X-Gm-Message-State: AOAM530ikGjDNcvrZoN1HCkJMNLxKHlvig1NbNM6xWG6LyB1g4SHNf9O
        T8EakCKPv0Ue05nHH6E3b7Ex4TaxpB9nuA==
X-Google-Smtp-Source: ABdhPJztG0/9t+JSf3xY8pKj85r+cw6PeMBfjKBfhg0qbsNm8ucVqvzX/iAm+2VYevGSspxPysZCYA==
X-Received: by 2002:a05:600c:4fcb:b0:389:d27f:edc7 with SMTP id o11-20020a05600c4fcb00b00389d27fedc7mr15420328wmq.152.1647141491362;
        Sat, 12 Mar 2022 19:18:11 -0800 (PST)
Received: from DESKTOP-26CLNVD.localdomain ([102.91.4.21])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm29135709wmq.27.2022.03.12.19.18.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 12 Mar 2022 19:18:10 -0800 (PST)
Message-ID: <622d6272.1c69fb81.82da3.eeea@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <deargideon04@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler  <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <info@gmail.com>
Date:   Sat, 12 Mar 2022 19:18:02 -0800
Reply-To: mariaelisabethschaeffler88@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich lesen

https://www.forbes.com/profile/maria-elisabeth-schaeffler-thumann/#443b4a6e=
19c7

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email:mariaelisabethschaeffler88@gmail.com


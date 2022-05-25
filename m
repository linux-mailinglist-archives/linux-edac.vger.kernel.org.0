Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3974F534536
	for <lists+linux-edac@lfdr.de>; Wed, 25 May 2022 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiEYUsA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 May 2022 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiEYUr7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 May 2022 16:47:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3952B2258
        for <linux-edac@vger.kernel.org>; Wed, 25 May 2022 13:47:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-300beab2b76so15791617b3.13
        for <linux-edac@vger.kernel.org>; Wed, 25 May 2022 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+uyh4vUIYntN7Mid2B5fbgguOxBR2RiHnKBh7A4r37I=;
        b=PnromsGSl/VyCqJRnnJHQGv2emL8SwMg8ftXDY1M1kfjEHhbW+SFcNbx3DogMg04Y9
         /oZIr62MobI8ksksf+p9sBio2Dq2yBIBPcLJ3b1SShimWCeBsnvQbeReD0NRZ7Om0Lst
         q1lisGYBsy1KTkD8a/a+P3V6h5TEOEvizQbKOIY52MNwlZwBpCdF++HQA7VleD8dxYmT
         47CCQBdH112dj3BW1XZfHpBYhUz6nflHJwVhKJ1dOqZAhIGbRVTP42myeLGtiu1ATKwe
         DXnDVSRqAyDH9FmgiIci81QGTqI4p/Sz0r5xM/GwgFW8dm98Yai8Vi1EO7F7NXK45ral
         Mg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+uyh4vUIYntN7Mid2B5fbgguOxBR2RiHnKBh7A4r37I=;
        b=1276S2ps9nCn61d+8vv4wL24NjZW1WtED2QTWNJvoaGZ3p4ogUlijJLdZq7ivJWJVQ
         1saq8Oa3lGVBzbXMJuGd40hvgd/q5WCoeEN8aRUH5cIyr5LMEbatLPMx3ciGgYTygl/K
         04pV67/CpGp8TdFZh8lqnCVV0NufqABaTqbUpVnWuyHr6QPTC0R7QwdRvx7dQYzwD40U
         o0UiWkb5yPJqT4Xw4EugVMlzUN3xOuEWSP6784Ni5dR594xrW5DP69co3nRRPAIrlvm8
         TEXominqhhB3/s5sZ0SUyUdXSLadI/leOfPSpweVy9e4m3ilfeNbqDX1xwOSqgppbU+M
         yOjQ==
X-Gm-Message-State: AOAM530j7Cure1ksLCQuBR00rnR5GrpIrIjELkz6wRFZNFxly2OCK99X
        ZEuWEPfReo140l0aM1Ma+s7v16VlWIBewk4Tr4k=
X-Google-Smtp-Source: ABdhPJwSUXt4OSD1heOIQ3zIbqBs1JquJNu8NtOAfWl74I7duJ3I9S+mgyYgK4KvmN58QkVh9RTAkFFWkd3+8Flvjy4=
X-Received: by 2002:a81:1f8b:0:b0:2f8:5846:445e with SMTP id
 f133-20020a811f8b000000b002f85846445emr35075611ywf.50.1653511677047; Wed, 25
 May 2022 13:47:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:3682:b0:17b:2b7b:c035 with HTTP; Wed, 25 May 2022
 13:47:56 -0700 (PDT)
From:   Colina Fernando <colinafernando724@gmail.com>
Date:   Wed, 25 May 2022 22:47:56 +0200
Message-ID: <CAP7Hh1-qYQ=wBUq_p5pXQrtkN1XpxJSADCpbiay82rCojSvQDg@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Fernando Colina

colinafernando724@gmail.com




----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Fernando Colina

colinafernando724@gmail.com

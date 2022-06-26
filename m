Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E155B10A
	for <lists+linux-edac@lfdr.de>; Sun, 26 Jun 2022 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiFZKLa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 26 Jun 2022 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiFZKLa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 26 Jun 2022 06:11:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CADE99
        for <linux-edac@vger.kernel.org>; Sun, 26 Jun 2022 03:11:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so6740660pjv.3
        for <linux-edac@vger.kernel.org>; Sun, 26 Jun 2022 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=LasKyUG7aDV4h4e/gS2Fbeb/OwYu3XTv/bikRfIZeRB28koZs8hGwtPCUxe00L3RST
         jSof1ufc/UJSsJUfTAp4xa1V7sE+3HzfPoP4N1nLAXqLV5MJrVDWThrWDftFM6XgcGsW
         y4JuHThWBW2Y9yyk2wJuX3WIvbPBW65FnLXOwQPQ8Qt7EWT68pUUT96Xu9wZJUtxf0Rq
         HIBGwcgJyqw4vZE3Un9mqqIDoQq3+SAdv4J2kz2ICYaeJtJ1FSvsJ9wu6UAO7d2XKm/X
         jd55PGeXp+oxu/qj3S10KZug4K+i+XIjI9Cfe+mMs3YX+uw1v8yj8sW+/FFWZDdEElzV
         svRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=tayP7M8m3J3dX7qOOAxfpoMiZxAsVkYXg1b0ATtbUSqcJiQu2uBvpHn9CN0OdzZvX8
         N4/W8vpcTacBlRZKPLA4PjmVMVURU21IPohmi7LH4A7pv4mpF/8QoUb+lRZJ2kUFiB3a
         kLYRcjTnO9g5LEfyDUeSgDE+rOoY+O2wI80ymkRM6qTdGtDCuaW1cA678Vxw8YmozY1r
         UXRTh/xLPfs1MHQfaZF9JKa+oJMYd6spWIfhYb8n3gL7bdQu4b5dXzVdoKttAvIZX0Vf
         lDUzVD56NdmV44RtaXYuBV4I2aDIxzCZOV0nxzUPxBh4/6QwNyWIHMt1N+UwqkX+FjCD
         6SLA==
X-Gm-Message-State: AJIora9Z/Yw70Z5YM9QSpftnckBQIgv5/9++mD9+PK1G99Qfe7MnYhnB
        x2uLGmKKc+mq/RVTNHB2sTCJ6ywfuy8eiFBCmo4=
X-Google-Smtp-Source: AGRyM1sNX36lDRPz/j2GmfEYEMAp/PEGaCkPijihlAe+phNwvLUSPCVPfj2k8MCpwSyJddntp1NPI7LcWQu7wRmBfrY=
X-Received: by 2002:a17:90b:1d84:b0:1ed:5918:74e3 with SMTP id
 pf4-20020a17090b1d8400b001ed591874e3mr2575718pjb.173.1656238288492; Sun, 26
 Jun 2022 03:11:28 -0700 (PDT)
MIME-Version: 1.0
Sender: bintaahmed2030@gmail.com
Received: by 2002:a17:90b:4c47:0:0:0:0 with HTTP; Sun, 26 Jun 2022 03:11:27
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Sun, 26 Jun 2022 11:11:27 +0100
X-Google-Sender-Auth: pCqhE6bM0lAG0DF3-cbWcEcISy4
Message-ID: <CAGQNKtTAAFj02-BBa4YX7eH-GdgPvvS8ZvNbCpkqjdrJBoeerw@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa

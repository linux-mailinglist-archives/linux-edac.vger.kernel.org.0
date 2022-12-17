Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22464FC1A
	for <lists+linux-edac@lfdr.de>; Sat, 17 Dec 2022 20:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLQTTs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Dec 2022 14:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLQTTi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Dec 2022 14:19:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6281145D
        for <linux-edac@vger.kernel.org>; Sat, 17 Dec 2022 11:19:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n1so5413457ljg.3
        for <linux-edac@vger.kernel.org>; Sat, 17 Dec 2022 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=co845zATjNde3H5Vab75OHgk3idEhiLG/pEEUCj10gcAoDAyvmeJAIeMxCfnQGfMIj
         Rk1UG8EI2HIZdCTH+rCQOQzKujnOf5QJIXBhYHkxNHlJG9CcNjN7WQ4xlB1kNwhkN8ot
         bySEJQY71GV9PRSPnGXr4TULJLKUoGrW2CK+pJVL2WATO4mZvX894mFw9qL8QQD0X6ro
         Fqjbs/TnCSBvt4U1yQCDzAQGECliLgB7E2uqWVMBuiCYj3tftR2qqqE9vh1EcHoSKkxX
         d4OekhX5/HkfsxiZ2AetCzlgHp4iJisyy4ShWo/miO0A0HB4Dp47RMog44iDMpmvdM9M
         48zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=VcKHiy61Xpi2jzNxe+rP42R/5b/ZvVh6yFczy1SNQfFsCJ8qoAzrpA0t6hJ892PnCL
         qqV4yX5emhGdXNH8Q4eWjESJU6WtZJdTP6uIQ8q4gpwKHvnK1imu/XiEzq9utk384Uxv
         5VhALEvHRaFFv/Tt8/vuF+ngnidH3GJ+BuZnQe7cgiXYQfB55UAu2MPbhAO6B7WbducG
         f851p4hdea4mOvzQItGxb5iUWMM0io1Kq5tDp5ZFPGnFzFTN3gRVjaezFL8qirQFkXl+
         UpyXJ8NRrdnpikq8BdjGPXMfp0qU0z1rodbAUUlty7bGm1eBIppkWftB37e8NgD/K1/c
         Rv3A==
X-Gm-Message-State: ANoB5plB7eVgVCjeg7aS1xa928jqaDzC+d3JmELM5+rAsDEbADTZTLcw
        YcNzF0bWRdskg+jJTjWTtE5bRa75m6UWL6mZ11o=
X-Google-Smtp-Source: AA0mqf6xSItA2XQtcM7sDNE5bL4/miBLIHwhO/163TuimuwMTWTOthVLV4AHM/dzhjpR8p76ANGRnqUhBonlbOpvWGs=
X-Received: by 2002:a05:651c:221e:b0:277:6231:5a7 with SMTP id
 y30-20020a05651c221e00b00277623105a7mr23904920ljq.300.1671304758949; Sat, 17
 Dec 2022 11:19:18 -0800 (PST)
MIME-Version: 1.0
Sender: ourosafiyan@gmail.com
Received: by 2002:a9a:5dcd:0:b0:231:8098:e780 with HTTP; Sat, 17 Dec 2022
 11:19:18 -0800 (PST)
From:   John Kumor <jer.91244914@gmail.com>
Date:   Sat, 17 Dec 2022 19:19:18 +0000
X-Google-Sender-Auth: _WrBjDnmT_vROY9jxuAUQdm1_qI
Message-ID: <CAMh9-WMydoRBszphiW2RoYnkAc5+MuD0HGzHW=V2nY6555dN3Q@mail.gmail.com>
Subject: It's very urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,

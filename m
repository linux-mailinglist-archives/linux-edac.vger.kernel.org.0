Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63C649027
	for <lists+linux-edac@lfdr.de>; Sat, 10 Dec 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJSfB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Dec 2022 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJSfA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Dec 2022 13:35:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3951742B
        for <linux-edac@vger.kernel.org>; Sat, 10 Dec 2022 10:34:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i15so7434603edf.2
        for <linux-edac@vger.kernel.org>; Sat, 10 Dec 2022 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wKhlTcOy+a42ALgXnObnBcqmMWwXiPNKOmiJwv4kwGw=;
        b=JiM79MJZEwnBkl+gkJX4zhFo7STQSO9CIud7miKOqp1uVqg6C6fY+r2NAUhXlQUVaf
         yMojuI9mGWLsvxj/uZBcpGzT+MLQnrjscQbMsKHHDy3B7BQ/Gq1Wmmb2c3iG71YCCpkL
         C9KRg2rAl4mqaPiYCL6JQW8Ot8XZilW5spiEfH8gYm8S1bhdZ9K8qX+kvG8AZcjRkxVB
         xPFjPZ64lneEiXGpDliMIxyZBLmBaRLfXBvjGR40S++ZFX9gaUqnQYLKodounqdJCLCE
         UoKjWG2ePLFRSELgU4uMacHdSQOt3oTHrF+5VfVn9ni2vWZH0qV0X/OjXbkdY61DsCRT
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKhlTcOy+a42ALgXnObnBcqmMWwXiPNKOmiJwv4kwGw=;
        b=aJa/Y/3yIhZNqBSW/zfi/cW16t9cFtzUn97uiFk+lMoqAkMaM4F1DE/GamZfHEfc+w
         VyiOPbbSJvLnFxnauYHIllxWZg+fGWKWKq+DlukxRybTk9g/Mk5D2WASfu+vsAxlvVpY
         OkZ0lmLKEKG5DIxhoGNAUSRBOkbADf5gUAClIbONjnsT9VYJdrefh1hpj0Y4wfs5nFRm
         ZJQfUNUqZPjBcB/K9YaHUefXFEUCGEKKbAsV0uIbcs/FMys88gVh5KsHmxcZ8UfRmOzC
         ylTzkmb7KN3vg2uJNaYjyMrONLEinF/thQthn38Uhag5vEVQJZWhSHbkJkHjY4D3RDNt
         9s1Q==
X-Gm-Message-State: ANoB5pkfc5KAe/Wo0Pyhw4LzOYstsbnWAXONEjB9ZT2SiPKn7qD4IKiS
        6xuB3LiTZ79sZ+cCndi1qblKJqAVlR75A3IkQNQ=
X-Google-Smtp-Source: AA0mqf7gS+m9BYDwX9JrgpQ3omqys/tLKVjR6euR7TM6emXhZu5vM+7qO40zGaQt9Q5JBUJ1bi2RHFtNvSYAzyuX6do=
X-Received: by 2002:a05:6402:1145:b0:46a:d5ee:d150 with SMTP id
 g5-20020a056402114500b0046ad5eed150mr49225581edw.312.1670697298138; Sat, 10
 Dec 2022 10:34:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:204:b0:26:8e33:9fe4 with HTTP; Sat, 10 Dec 2022
 10:34:57 -0800 (PST)
From:   Johnson Obedy - IMF -World Bank Services UK 
        <thisisjohnsonobedy@gmail.com>
Date:   Sat, 10 Dec 2022 19:34:57 +0100
Message-ID: <CAM7UOsDz7kb2Jq_tpJBt9ww0BwKyHe6bJa8cX8Bn1MCua+_Zcg@mail.gmail.com>
Subject: Dear Sir/Madam Partnership
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_80,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52e listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8071]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [thisisjohnsonobedy[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello dear,

My name is Obedy Johnson.. Please, I have a profitable philanthropist
project (US$2Million) proposal that I wish to share with you. This
may not be your area of specialization, but it will be another income
generating project for you. Please let me know if you are interested.
 just your trust.

I am waiting for your reply.

Best regards,

Obedy Johnson

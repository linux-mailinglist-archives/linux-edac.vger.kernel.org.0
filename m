Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508959EC68
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiHWTeF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiHWTdr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 15:33:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB710FFF
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 11:27:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-324ec5a9e97so401582237b3.7
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=N0I3CdJEfwJeYkVc5+xn8APa4bb7iTvGVErk8KWs1dyVDqMzQzHR79fA9W1W9z9B14
         yuehYeK7fM/wHC0aS40OwqfDzeN/fkb1AJpwwBLd+Qk2wlwtMAmWOcJHahewNvvfd+cc
         9sU9Xa07ZIKK5pa3T6vpACg3fB25u3A37l0aEGIO4sOe6RV4a3t10MyuwhMNL7iEiHTu
         dLnkQVc5WsJfkP29i+WJPmPXc+JVCJjTbMwwMHmewc3S/Mz1o3D40sE6HxPiVMlaV7yN
         U/Lfh05Rf5NizigKFe/Avehqkf1/3e57OTlImNC8iggi8jewxLjJGCNRsTLVwqghKG+9
         nj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=Pb5pln65JSPP4ghvjgrLwF7tW0qYJB400lc4HLNqz8DJ+J+frmNCi+3RKF0N/ot35W
         VY32OPx3sakqh1jWy35uMxS14kC8TGkyLvAawFzmCqeGjSzp4LRq6/zMnaKV+sN6Ck1S
         sNZzKTKRP05Y1ecQvG2D2Mh5LexPWlRuxZWYAJWqOFCPdflWgcvAHplB40KePNnRHBkL
         q6lIFiynJ30MoEUs/h5gzOiz407gO17JWYDa9M7ltGCwFMm7+h7VUAaAKaKvILQvbFjw
         UtsHekaLqoCyO6WaDv1B3ju/avO/7h9TtKHLiLoqzt7dcR8McADNHr2BMdLDEKtqlIlu
         SD8A==
X-Gm-Message-State: ACgBeo31OojnA6PaJqcCmj/HAkRAcNaYDR+rg+vM5X7scD+39y/+t/MX
        7xO63M9SNrJNQtsTXkKsMtD0BZWgKxc3vsu5vZU=
X-Google-Smtp-Source: AA6agR6JC/D03ie3Qk2blRjGoxQqwGmASZtrUgaq8MwAA8j4N6+Xov77f/J4kHvf+V2ql6hUKFiQFJ9cUbJxMb8CHMs=
X-Received: by 2002:a81:1d53:0:b0:33d:794b:ff1a with SMTP id
 d80-20020a811d53000000b0033d794bff1amr5464571ywd.336.1661279244732; Tue, 23
 Aug 2022 11:27:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:d30c:0:0:0:0 with HTTP; Tue, 23 Aug 2022 11:27:24
 -0700 (PDT)
Reply-To: fred49508@gmail.com
From:   "Engr. Fred Martins." <lorir8611@gmail.com>
Date:   Tue, 23 Aug 2022 10:27:24 -0800
Message-ID: <CABJ7TC5qpUYrKW8ek1Rbprx7idUUm69ti0qnVa-82SXBU71Tbg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5148]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lorir8611[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lorir8611[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fred49508[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,

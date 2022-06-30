Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9031562078
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jun 2022 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiF3Qkh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Jun 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiF3Qkg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 Jun 2022 12:40:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06693BA45
        for <linux-edac@vger.kernel.org>; Thu, 30 Jun 2022 09:40:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q9so23851241ljp.4
        for <linux-edac@vger.kernel.org>; Thu, 30 Jun 2022 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RKN8JemtiEhSO+mLfGbaElPk0n/w1+KFv/CRb4j+KbM=;
        b=gaMRSl2PXc4Go3V4J9LbPysJd5f22F14jeWKGlI2ofQZIRkTgowL+DM+lu9xD1+4gg
         MhQ/iNidP3U00EQHK+YKwDwD/pWzxWuWo849gmF00aA4hVZWW7iGiI01WC7h5Clkcomn
         2HYx6d+e7DUGkF34cHin9A/T2gxFEfnkVwyK2wfM1DvYzoQ7JswmCcKdi09Jwg0F7GXM
         VKAd+VDqztjSUgq/kqB16PEXxBko6OmgNTowKR9cg2wMMPEa4Fxb/I0Fo7OUVtSQaUet
         O2Fs8KMseBU6iwRP5Ssi1gYFdEFETY3P0BV8Tlm8Cu+VG1+bbccCbwq7uZYiFzJP8CIE
         puxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=RKN8JemtiEhSO+mLfGbaElPk0n/w1+KFv/CRb4j+KbM=;
        b=sNr4S5URXF3GMSDiCccCGOXklRIVxB6K620LRKXJSWyHq8SutJB/ZmPVQ1nlUjBUKt
         BEN2j6JFiOPGQ3GErF9AgfCgPDEah1aloS1e7amqtVIUswPcMXEeRT9ixaQXtIkKv4D7
         0R94fMXzAvA25BWsp2nt/dl1V7yrzjskkOSdJdO8PtgD8GGMNFB3aAPoak3ed7Y+vYFo
         xEH8aLJdqD3r7+pve+FE8qTUXbkDukTlJ7l/weTISavMSpAZYOPH72QcqQF6YaYaEaXS
         DhmLdqE1i8nphTVj6mMOQCLBwTi8/1cTBbWB4+nikIkZHxDarIn9PpCOpIxQSguQxaj7
         fBag==
X-Gm-Message-State: AJIora9LvwrfZphxn+fW4PLcfMBIaKnclvS09jTzX5JUKTgPi8AMyrXv
        +Ydqdxii9fN6wPkMGtM2Rv+k8S/a9H2Ut4zNx+M=
X-Google-Smtp-Source: AGRyM1vglj45Pl7+LmzISwWcIWh0SWd5ynH2/ZYBmYadvQSIs6eMH2BEnuFCcU1IzOCGLJt15iDvR41bIsv1Cts9yio=
X-Received: by 2002:a2e:8795:0:b0:25a:926c:e45a with SMTP id
 n21-20020a2e8795000000b0025a926ce45amr5726429lji.438.1656607234281; Thu, 30
 Jun 2022 09:40:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7dca:0:0:0:0:0 with HTTP; Thu, 30 Jun 2022 09:40:33
 -0700 (PDT)
Reply-To: westernuniontg453@gmail.com
From:   POST OFFICE <domuomor@gmail.com>
Date:   Thu, 30 Jun 2022 09:40:33 -0700
Message-ID: <CAExakiAy8NO_a+hBL5xqa_9SOvJEWPp6YnjSW4byB9AM_kH4ng@mail.gmail.com>
Subject: =?UTF-8?B?5L2g5aW95Lqy54ix55qE55S15a2Q6YKu5Lu25omA5pyJ6ICF?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [westernuniontg453[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [domuomor[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

5bCK5pWs55qE55S15a2Q6YKu5Lu25omA5pyJ6ICF77yMDQoNCuWbvemZhei0p+W4geWfuumHkee7
hOe7hyAoSU1GKSDmraPlnKjotZTlgb/miYDmnInor4jpqpflj5flrrPogIXlkozml6DkurrorqTp
oobotYTph5HnmoTkurrvvIzmgqjnmoTnlLXlrZDpgq7ku7blnLDlnYDlt7LlnKjml6DkurrorqTp
oobnmoTotYTph5HliJfooajkuK3mib7liLDjgILlm73pmYXotKfluIHln7rph5Hnu4Tnu4flt7Lm
jojmnYPor6Xopb/ogZTlip7kuovlpITpgJrov4fopb/ogZTmsYfmrL7lsIbmgqjnmoTotZTlgb/p
h5Hovaznu5nmgqjvvIzmiJHku6zlt7LosIPmn6Xlubblj5HnjrDmgqjmmK/or6Xln7rph5HnmoTl
kIjms5XmiYDmnInogIXjgIINCg0K5L2G5piv77yM5oiR5Lus5bey57uP5Yaz5a6a6YCa6L+H6KW/
6IGU5rGH5qy+6L2s6LSm5oKo6Ieq5bex55qE5LuY5qy+77yM5q+P5aSpIDUsMDAwIOe+juWFg++8
jOebtOWIsCA4LDAwMC4wMDAuMDAg576O5YWD55qE5oC76YeR6aKd5a6M5YWo6L2s57uZ5oKo44CC
DQoNCuaIkeS7rOWPr+iDveaXoOazleWNleeLrOS9v+eUqOaCqOeahOeUteWtkOmCruS7tuWcsOWd
gOWPkemAgeatpOS7mOasvu+8jOWboOatpOaIkeS7rOmcgOimgeaCqOeahOS/oeaBr+WIsOaIkeS7
rOWwhuavj+WkqeWQkeaCqOWPkemAgSA1MDAwIOe+juWFg+eahOWcsOaWue+8jOS+i+Wmgu+8mw0K
DQrmlLbku7bkurrlp5PlkI3vvJogX19fX19fX19fX19fX19fXw0K5Zyw5Z2A77yaIF9fX19fX19f
X19fX19fX18NCuWbveWutu+8miBfX19fX19fX19fX19fX19fX18NCuiBjOS4mu+8miBfX19fX19f
X19fX19fX19fX18NCueUteivneWPt+egge+8ml9fX19fX19fX19fX19fX18NCumaj+mZhOeahOi6
q+S7veivgeaYjuWJr+acrO+8ml9fX19fX19fX19fDQrlubTpvoTvvJogX19fX19fX19fX19fXw0K
DQrmiJHku6zlsIblnKjmlLbliLDmgqjnmoTkuIrov7Dkv6Hmga/lkI7nq4vljbPlvIDlp4vovazn
p7vvvJrogZTns7vnlLXlrZDpgq7ku7bvvIh3ZXN0ZXJudW5pb250ZzQ1M0BnbWFpbC5jb23vvIkN
Cg0K55yf6K+a5Zyw5oSf6LCi5L2g77yMDQoNCuilv+iBlOaxh+asvuaAu+ebkSBNYXJ0aW5zIE5h
bm55IOWls+Wjq++8jA0K5oC76YOo5rSb576O5aSa5ZOl44CCDQo=

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858D5384C6
	for <lists+linux-edac@lfdr.de>; Mon, 30 May 2022 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiE3PX7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 May 2022 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbiE3PXq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 May 2022 11:23:46 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA01406E7
        for <linux-edac@vger.kernel.org>; Mon, 30 May 2022 07:24:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s19so3547235ioa.6
        for <linux-edac@vger.kernel.org>; Mon, 30 May 2022 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=LVGtkaW0HGDkcFAbs1GdFvAiqvfLTx1bYwe9OYqpie0hnkrRG3ANYxPumKuZYk7JMA
         AfITdn4F5UEIeokR125RIY7Q1ckTrFsya4ogv4jGBKCCAup79jetDFmsmII3tXW0NH9U
         HmEtro8tuihDrKQfSM37+WAX2S6ccLGt/leKPBqVvVnXXzZUwGgCNWgxjRzx+ta8kb/N
         kjp3vJtP4Wr0Z99l39qc43HumPvgMdcTmaO69S36D8nN5QUsfNvdQh/YlqsB5wr2kDuQ
         A0nhfxSHPFeuwsEWpzg0d/VjIUjssp5aWeegsjCH7CSUHmX4+cmniMZIKUoaDKh7uonN
         KAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=lGNWZh2KC5Y1jRr+ETd6F9EvXbjRGxMnUY4dZLdydlzmA+eLNXACvoycd5nEPS9gOn
         ER2lPEfP9YRTewl0X/xP59tlnkUum63E0kD7J8D011cysH96Be8jxx0gyi0nKAtiVjDA
         TaR/Su+ivIw1JmrYTs48dtTGGMb+Rgpy66E2zn5am561GQeJ9C35oEMY1OtvD6BSs60N
         2NMtN+PLf02bCdI8EVEsr6yjyLywN+tJyvaLq474MLBFbyb1zF6ZDUJLioXtw/tLl2dp
         4fSP7kNh1ctHQoldo2q/PQo81GpTl9uPB1Td1BsJTj6JNOVoB4VfjV+hyiTrYZvv0EI+
         Abag==
X-Gm-Message-State: AOAM531DxuZPCfuLLr0JmsCmVTkGyYo+9GOXoxsRrnddnsdSY0jXbx61
        QlBO+wj+vIKSe02RFYW8ymTjGd9H1/58d0FKPhM=
X-Google-Smtp-Source: ABdhPJzISoeKuHvleT2qC8m0US7O2OdfkIZVgxD6GvVL7FgBjA1K4iWV+Cy+Hb9xQJJxwRGXQNwhpr3idZ5yq0RJcI4=
X-Received: by 2002:a05:6638:13cd:b0:330:bc2b:d8f0 with SMTP id
 i13-20020a05663813cd00b00330bc2bd8f0mr11889080jaj.41.1653920665532; Mon, 30
 May 2022 07:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:f06:0:0:0:0 with HTTP; Mon, 30 May 2022 07:24:24
 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <koadaidrissa1@gmail.com>
Date:   Mon, 30 May 2022 07:24:24 -0700
Message-ID: <CAOh7+P9ggdh-bYDbwixYyVB38v5qx=PFTHiUOv+TH9fUGcn3NA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d43 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koadaidrissa1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [koadaidrissa1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGVsbG8gZGVhciBmcmllbmQuDQoNClBsZWFzZSBJIHdpbGwgbG92ZSB0byBkaXNjdXNzIHNvbWV0
aGluZyB2ZXJ5IGltcG9ydGFudCB3aXRoIHlvdSwgSQ0Kd2lsbCBhcHByZWNpYXRlIGl0IGlmIHlv
dSBncmFudCBtZSBhdWRpZW5jZS4NCg0KU2luY2VyZWx5Lg0KQmFycmlzdGVyIEFtYWRvdSBCZW5q
YW1pbiBFc3EuDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCuimquaEm+OB
quOCi+WPi+S6uuOAgeOBk+OCk+OBq+OBoeOBr+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/jgajpnZ7l
uLjjgavph43opoHjgarjgZPjgajjgavjgaTjgYTjgaboqbHjgZflkIjjgYbjga7jgYzlpKflpb3j
gY3jgafjgZnjgIHjgYLjgarjgZ/jgYznp4HjgavogbTooYbjgpLkuI7jgYjjgabjgY/jgozjgozj
gbDnp4Hjga/jgZ3jgozjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K5b+D44GL44KJ44CCDQrjg5Dj
g6rjgrnjgr/jg7zjgqLjg57jg4njgqXjg5njg7Pjgrjjg6Pjg5/jg7NFc3HjgIINCg==

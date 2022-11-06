Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14961E263
	for <lists+linux-edac@lfdr.de>; Sun,  6 Nov 2022 14:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKFNjR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Nov 2022 08:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFNjQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Nov 2022 08:39:16 -0500
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 05:39:15 PST
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DC20F1E
        for <linux-edac@vger.kernel.org>; Sun,  6 Nov 2022 05:39:15 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 21:33:01 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 21:33:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] EDAC: altera: Remove unnecessary print function dev_err()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <cf4581a.ba.1844d24fef3.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3jOKOt2djuokBAA--.55W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQATB2FEYx0CNQAJsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RWxpbWluYXRlIHRoZSBmb2xsb3cgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9kcml2ZXJzL2VkYWMv
YWx0ZXJhX2VkYWMuYzoyMTUzOjItOTogbGluZSAyMTUzIGlzIHJlZHVuZGFudCBiZWNhdXNlCnBs
YXRmb3JtX2dldF9pcnEoKSBhbHJlYWR5IHByaW50cyBhbiBlcnJvcgouL2RyaXZlcnMvZWRhYy9h
bHRlcmFfZWRhYy5jOjIxODg6Mi05OiBsaW5lIDIxODggaXMgcmVkdW5kYW50IGJlY2F1c2UKcGxh
dGZvcm1fZ2V0X2lycSgpIGFscmVhZHkgcHJpbnRzIGFuIGVycm9yCgpTaWduZWQtb2ZmLWJ5OiBL
YWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9lZGFjL2FsdGVy
YV9lZGFjLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2VkYWMvYWx0ZXJhX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9hbHRlcmFfZWRh
Yy5jCmluZGV4IGU3ZThlNjI0YTQzNi4uYmQ1YjE1Y2ViODcyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2VkYWMvYWx0ZXJhX2VkYWMuYworKysgYi9kcml2ZXJzL2VkYWMvYWx0ZXJhX2VkYWMuYwpAQCAt
MjE1MCw3ICsyMTUwLDYgQEAgc3RhdGljIGludCBhbHRyX2VkYWNfYTEwX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAKIAllZGFjLT5zYl9pcnEgPSBwbGF0Zm9ybV9nZXRfaXJx
KHBkZXYsIDApOwogCWlmIChlZGFjLT5zYl9pcnEgPCAwKSB7Ci0JCWRldl9lcnIoJnBkZXYtPmRl
diwgIk5vIFNCRVJSIElSUSByZXNvdXJjZVxuIik7CiAJCXJldHVybiBlZGFjLT5zYl9pcnE7CiAJ
fQogCkBAIC0yMTg1LDcgKzIxODQsNiBAQCBzdGF0aWMgaW50IGFsdHJfZWRhY19hMTBfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKICNlbHNlCiAJZWRhYy0+ZGJfaXJxID0gcGxh
dGZvcm1fZ2V0X2lycShwZGV2LCAxKTsKIAlpZiAoZWRhYy0+ZGJfaXJxIDwgMCkgewotCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJObyBEQkVSUiBJUlEgcmVzb3VyY2VcbiIpOwogCQlyZXR1cm4gZWRh
Yy0+ZGJfaXJxOwogCX0KIAlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YShlZGFjLT5k
Yl9pcnEsCi0tIAoyLjI1LjEK

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98356301AC
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfE3STe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 14:19:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3STe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 14:19:34 -0400
Received: from [172.20.8.77] (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1E911EC033F;
        Thu, 30 May 2019 20:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559240372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FySjQvkw3gub2985lSwYfwdxjK48qhJJdaawn7bwWw=;
        b=cOO6KmApd03PNn2XMw3Tn6baTYU4r7UAS1R913nuS0nHijjQ6j8BDkFWp6voJjGQEy3tgO
        3fs7DJOfmS6pj8ZteGTAFM2et+0JKArhtHQvmGZi3eS3W4vzKN4WQoBTZmnac5oF95KgHh
        IiUG2E6k9av3XSOGh2eYfXobE1A7Tr4=
Date:   Thu, 30 May 2019 11:19:27 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com> <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     Hanna Hawa <hhhawa@amazon.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, james.morse@arm.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com
CC:     ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On May 30, 2019 3:15:29 AM PDT, Hanna Hawa <hhhawa@amazon=2Ecom> wrote:
>Add support for error detection and correction for Amazon's Annapurna
>Labs SoCs for L1/L2 caches=2E


So this should be a driver for the whole annapurna platform and not only a=
bout the RAS functionality in an IP like the caches=2E See other ARM EDAC d=
rivers in drivers/edac/ for an example=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 

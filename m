Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42539E9FB
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 15:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfH0Nt1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 09:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0Nt1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 09:49:27 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A2522DA7;
        Tue, 27 Aug 2019 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566913766;
        bh=t8dV1JQ6YjWzp6xWQVowBI3+h+v4134YMz5+lu9L+/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vxThKCxhmjAnNTIY32ynwA5M4uCpDxXpUzkUdSxei05qZyPP/qcipIdYdgpontZLS
         YqQzblm7YkM8uRqS4nEl7X1l4vp8fthLL9yo5ADW17nizmtUmnpOpq4umYZW1M12Td
         k7lg97H0TlLoWg+cDwA12rm24mMpngjjXbqBxIN4=
Received: by mail-qk1-f169.google.com with SMTP id m2so16982196qkd.10;
        Tue, 27 Aug 2019 06:49:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWrxOReXJ7N/us0vxxpIxYuSwtegYzQ/YmtlSHiBss4grRaTBaJ
        trm5hVqpyA+xN6UFTLFi1nirXb6/IOeDHjRJXw==
X-Google-Smtp-Source: APXvYqyzUQ15boR9MbWaQGb4gGOqWJfi8CzSbuazLWRrpy5Me3zhwjIkil7L3eEEZiEqqtxcmVl0NXeT5X4kfIDHEnc=
X-Received: by 2002:a37:4941:: with SMTP id w62mr19882827qka.119.1566913765684;
 Tue, 27 Aug 2019 06:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190805143911.12185-1-hhhawa@amazon.com> <20190805143911.12185-2-hhhawa@amazon.com>
 <20190821191704.GA32425@bogus> <1d23d7c5-cd7b-1512-5300-d43e82ba6dc1@amazon.com>
In-Reply-To: <1d23d7c5-cd7b-1512-5300-d43e82ba6dc1@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Aug 2019 08:49:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8jGbR4u7FA8r0gP5i2H+nSgOkGU_5mfiL=i=c0sOW8A@mail.gmail.com>
Message-ID: <CAL_Jsq+8jGbR4u7FA8r0gP5i2H+nSgOkGU_5mfiL=i=c0sOW8A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, benh@amazon.com,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 26, 2019 at 9:49 AM Hawa, Hanna <hhhawa@amazon.com> wrote:
>
>
>
> On 8/21/2019 10:17 PM, Rob Herring wrote:
> > Why is this even in DT? AFAICT, this is all just CortexA57 core features
> > (i.e. nothing Amazon specific). The core type and the ECC capabilities
> > are discoverable.
>
> Added to the DT in order to easily enable/disable the driver.

That alone is not reason enough to put it in DT. From a DT
perspective, I have no idea what the whims of a OS maintainer are
regarding whether they want all this to be 1 driver or 2 drivers.
(IMO, it should be 1 as this is ECC for an A57. For a core and memory
controller, then 2 seems appropriate.)

> You are
> correct that they are CortexA57 core features and nothing Amazon
> specific, but it's IMPLEMENTATION DEFINED, meaning that in different
> cortex revisions (e.g. A57) the register bitmap may change. Because of
> that we added an Amazon compatible which corresponds to the specific
> core we are using.

'IMPLEMENTATION DEFINED' usually means not defined by the
architecture. This doesn't seem like something that's going to change
with A57 revisions. Plus, the A57 is pretty old now, so we know what's
out there already. In any case, the revision is discoverable too, so
we could deal with changes between revisions in any case.

Rob

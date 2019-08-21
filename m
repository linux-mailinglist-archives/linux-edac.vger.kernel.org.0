Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9118E98431
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2019 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfHUTRG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 15:17:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39460 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfHUTRG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Aug 2019 15:17:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so3129779otp.6;
        Wed, 21 Aug 2019 12:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QMM6X86ZE4m7WOOCA+numF1SrsPevg8RcLzZaNb79Q=;
        b=mUhrwKZpFNyp3beHAxz5rIMZHI454dEots5EeGYo83UaPbwqzTbB6C2GioR5Ej3pvz
         9UF/YHIySpqVxOkRr96NJI6BKMQOClosP40RR6VwD/WTezXEtBCBIITFisvEFWIxLCx3
         StLO9N9VlY1xFQz4pBPoyJZLOQ5AlbtU7sJrQ0Wy2lLAg1YMLHpgN3FX2jezPrgsAtv6
         suim87k7P+zQmGmMIaV/CVsib2Q/4RWV46VOUTtBF/fVk9Aw0pyGwyVX9DAAW72vkhnv
         GGfLPcefJNh0jTw9AwOhNZiHtdsmgd6X8uSOeDKMnz4BfZYYkXYpwx6ZhQ8qrsX839Ip
         F90Q==
X-Gm-Message-State: APjAAAUkmQKfICnBUgIAsOO9qudrtzSFjoPd8ujk4Fi5oLALJGh/bN+L
        sKG8qTcAdmuxz10fvjfKNga9RIk=
X-Google-Smtp-Source: APXvYqx5PsTrBTUQAs9a8a7CgH0vWalbythAh/rmzUtUPMUX/sEYOLsQEUc3KVzZmH5LtUFbIRsbjQ==
X-Received: by 2002:a9d:7d04:: with SMTP id v4mr9302990otn.329.1566415025136;
        Wed, 21 Aug 2019 12:17:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b188sm6531532oia.57.2019.08.21.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:17:04 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:17:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     mark.rutland@arm.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1
 EDAC
Message-ID: <20190821191704.GA32425@bogus>
References: <20190805143911.12185-1-hhhawa@amazon.com>
 <20190805143911.12185-2-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805143911.12185-2-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 05, 2019 at 03:39:08PM +0100, Hanna Hawa wrote:
> Document Amazon's Annapurna Labs L1 EDAC SoC binding.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  .../devicetree/bindings/edac/amazon,al-l1-edac.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
> new file mode 100644
> index 000000000000..2ae8370216bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
> @@ -0,0 +1,14 @@
> +* Amazon's Annapurna Labs L1 EDAC
> +
> +Amazon's Annapurna Labs SoCs supports L1 single bit correction and
> +two bits detection capability based on ARM implementation.
> +
> +Required properties:
> +- compatible:
> +	should be "amazon,al-l1-edac".

Why is this even in DT? AFAICT, this is all just CortexA57 core features 
(i.e. nothing Amazon specific). The core type and the ECC capabilities 
are discoverable.

Rob

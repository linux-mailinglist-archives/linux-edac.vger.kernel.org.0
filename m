Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A81474DF
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2020 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgAWXh0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 18:37:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44047 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAWXh0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Jan 2020 18:37:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id 62so158666pfu.11;
        Thu, 23 Jan 2020 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnAOgh110uKPc3d8VRtFP1cCUwjRHhenRNDU4AcKph8=;
        b=K1vPMQgl/Yg+46UKknCjnjFG34twgu8GDgt+p5hRGEbg5j/8DXs0FedhC0j4h/53Vm
         r9HDbAatrCio+h9dR8/itKPROddqjz+l6/cpJlJ/goja6xaF7PmSF4k4BdfTSMXkjGwm
         3NMFtEPenDER9X7HM9w0a7sNEurnEcSojTlKBN87DC/te47lDw/wkZCSrTC05QP/p8yW
         lD7eEh5qASYejJRLu4FS16CYrMRG/ymjIXPwtgTBkXVk/McJ/67jK8v6sNX82eahfReq
         Vm1eFyHtM9MKOCDVW76a9jtDg9qEeWKR5XoAhdqnAeBNbZ0rY5g053dolcKC2yoQCc3l
         ejaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnAOgh110uKPc3d8VRtFP1cCUwjRHhenRNDU4AcKph8=;
        b=FxLMByBWZ/rdQHQp+9go9qsQRE5PluTWQhEZffT6a8t5djHXUpYx+tE6R1wuG3LKCk
         xK37ZgNp9V8mXIwgpUZrG8cLotiTgJKRWz3cXWXMW2uZrZ0rteCfrQsZ5XPXL9yhmwcr
         yrtojXMKrkZ3kVj2uSg8Q5+QSnZ5C2eyhSNYGOxWNN79R8zQQq0OeqHI64FbElZ0IP06
         KD/5DOmmQU35BiO5H1pjmEMFlKfXxNhEVjJ3dZnld5YpKAaIolUvzv+DrwXpAC7Pd1Ud
         SQ7yFebalpVIGOgCg5rkHIcmbuPyVRKYcKevz5/DFD0NYJSNwdhebfyBPUPY6m8YhDCg
         PW3g==
X-Gm-Message-State: APjAAAV/9cq2Y6Pk8td5YqVIBtJzMu4Giu4bZrkHsH+4vp7p/CxlNxoN
        ZjZdlupTL/zmm3Heax8Jml6+Nwey
X-Google-Smtp-Source: APXvYqx2Oz2x7aK2w2WY7H8GZslB2DP/lDmHVrC4VNx9P3gFaCAHqPF3LBhJCNPpT/oPHOgxMJR+ow==
X-Received: by 2002:a63:2e07:: with SMTP id u7mr877200pgu.295.1579822645505;
        Thu, 23 Jan 2020 15:37:25 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:140e:bf9b:65a6:dd72? ([2001:4898:80e8:0:9425:bf9b:65a6:dd72])
        by smtp.gmail.com with ESMTPSA id z30sm4042494pfq.154.2020.01.23.15.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 15:37:24 -0800 (PST)
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
 <CAL_Jsq+1S=mOS0-eb0=ibSn81ReDmDjrA9=bHpKC16w8B6Aq3Q@mail.gmail.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <e0bab7de-1308-409c-febc-608a812592e3@gmail.com>
Date:   Thu, 23 Jan 2020 15:37:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+1S=mOS0-eb0=ibSn81ReDmDjrA9=bHpKC16w8B6Aq3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/23/2020 5:44 AM, Rob Herring wrote:

> Run 'make dt_binding_check' as that would have caught this issue on the example.

Eventually I have the dtc with yaml output built and resolved issues reported by "make dt_binding_check". Shall I submit a new v11 patch for the dt-bindings only or I should add driver code patch into v11 too?

Thanks!

-- 
Best regards,
Shiping Ji

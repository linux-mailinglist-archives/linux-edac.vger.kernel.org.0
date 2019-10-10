Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE98D29F9
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfJJMsX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 08:48:23 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:43168 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733288AbfJJMsX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 08:48:23 -0400
Received: by mail-io1-f51.google.com with SMTP id v2so13295325iob.10
        for <linux-edac@vger.kernel.org>; Thu, 10 Oct 2019 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7hnwTmWKxZRMhBuGtUZVHMQJTMq8PwR793RimsSOwC8=;
        b=Rys6iX0aNnYNA2K7F2/6bqhp6i3T+jLnCG4t+ShzzdJd+f8WfnLvZYYMfPAAT+nKGm
         Bpo9B4/mpMCWjyDciNerWmLWRlzJDkCJrzdMHNNp6ZDJo3Ix5h+HhnSEi5FE1Gl9buZ5
         fFMdThGVl2rd0DTxRhQAL9vb6Kel8+VWi0hxlV8KJ6cSeGYbA/L0FIiIccN6w6VtyXJw
         Qz4wgndzglycEVmRWVA0qS94nMsRSF842DfbHlNTGwQauw29aCY8i1p5hd9OEix5YRI5
         4Fb3A6KnPun4k8sR7o0HxnBKzo/V6QNHzsx1UIZchPhBSsBFs9yaCvIK2s8IF9Thb5ed
         D3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7hnwTmWKxZRMhBuGtUZVHMQJTMq8PwR793RimsSOwC8=;
        b=cxy9+X0REt69hdBNznQLH7UNf/8Hhsj05eE0CVpKAtzfQL8qrj+Ks5gbfgA+n8+xVF
         4GJaxJFA/ovyA+kY0VRLm141csIm/QSjdyiIsNC5Qp7CD2E3vH6zZ5vQ28cR0oox8UhP
         2odKRAliG/5AYq9Z/sk2W44L0seuxAAwOdjlYRhDB2w/x93fEOJM5Ny1snF25DSKjq3j
         7pyWNcYNGVkDZfD3HXbYXZuCeDTYQCnQA/3IMUHTC+Qwh5MNE5tGFzZ2DjZc6KHhi7qB
         9S55dxAroM4aqm87X4JTmCkobsAucrkUQ/PoFHwoCZFBE4egLeNjETsCNJIINX43ZbzX
         kQHw==
X-Gm-Message-State: APjAAAWGTHGrPDCRFwEaLpLV2cZt/3HkNHGAsgu74wvxGpPGz8UUo14u
        LZ4+LjFftqH+xwu+3AJCdDR0XGK6
X-Google-Smtp-Source: APXvYqwiR/a8tmTTz1cIycA6fuBiQIWV36xPd2H6e1wg+ZEd5p6cKAl4gmdQ5O/cyJk8GHSppQA+5Q==
X-Received: by 2002:a6b:e008:: with SMTP id z8mr1450801iog.273.1570711702522;
        Thu, 10 Oct 2019 05:48:22 -0700 (PDT)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id c65sm1322364ilg.26.2019.10.10.05.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:48:21 -0700 (PDT)
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
From:   Jean-Frederic <jfgaudreault@gmail.com>
Message-ID: <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
Date:   Thu, 10 Oct 2019 08:48:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010095650.GC7658@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2019-10-10 5:56 a.m., Borislav Petkov wrote:
> Check all the BIOS menus. 
I did recheck all menus in advanced mode several times. I used my bios fairly often when I got this new system, I would also have seen it before I would think.

> Platform first error handling meands, the BIOS gets to see the error
> first. 
Thanks for the explanation.

-- 
Jean-Frédéric


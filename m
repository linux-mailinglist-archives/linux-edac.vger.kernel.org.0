Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749E41055B
	for <lists+linux-edac@lfdr.de>; Sat, 18 Sep 2021 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhIRJS4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 18 Sep 2021 05:18:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:37867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhIRJSz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 18 Sep 2021 05:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631956630;
        bh=iry8CxJ90YvNjBabfl8pNpq16ZRgsLo1wiD4DopXVmU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N5oBX9fJAM5iyWuylOVnewRLM5T8PbFyPWX5WoDIVrxxzEaifUei5SK4HbJaLcyhB
         mJR+WMiSp3QyFWhfZKVQGTm/aD5WeY/i+OsZ1fIV3JUkQX3pFihlSiCWZqp4qiMocw
         0M8GLO9j+6c609FcTk5bxH+vIQdau5X9WPcSltcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1mXIh03s1X-008aqz; Sat, 18
 Sep 2021 11:17:10 +0200
Date:   Sat, 18 Sep 2021 11:17:06 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mc: Prefer strscpy or scnprintf over strcpy,
 sprintf and snprintf
Message-ID: <20210918091706.GB2941@titan>
References: <20210903150539.7282-1-len.baker@gmx.com>
 <YT8S3poKyd5Nr5cK@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8S3poKyd5Nr5cK@rric.localdomain>
X-Provags-ID: V03:K1:x0hRNgzN/YTNYOtTnqiD/7Y0qsVVqL9WVhMPAY6LnNnNY4O2mkH
 oG+BnOd9niqyJRuLPBiDldfFUoeD85ilPs9KPbod2z+yNhyqhYRs+M5zTqhzOnA6fCLJiif
 UCclBZVfVw9wuZYAwoq/wlzZZGw4UVhTZvrZVP/eNvxEFn+R/AnhhLEkHLeUa1e8hu+4UqW
 UeC20cI2ifUtL4sp8gqFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWU3fgmMYgo=:XFGFwtM/KjC8HsB9wUwC8D
 tqSyMMJa3StwqxNbr3Il5Y4S+yMMFvhnERirF78hD5ipB0sbfKgAWoXXCSzlbfnt8xyH8Ktec
 K7xDCgNTalQX/8bT1Ttl8PFwcNK8gq/SdGkjXSs8sYIU53dQOMapjmx8uijekomsaCbvSG4Fp
 ZZP787y/zmDYfv0BBoZV2QJ9tjZYeT0GKzXmghPBg5Yorgqiw0fjiF8yP/WO7MQlIW9R7GxnK
 3k/2/98ZmIEn54yJgAP0FlAdTYOioYim398Oq+sEE7fSSZdTXrY3DdXXuYZlpcWMzH7yCV9P1
 8tALytVCBRcAlzpmMG0uTSD/TP0SLX/AtF3BQZySasu0Ye/Ygfa3oANc20bPurr+dnLh/txlG
 n/GMFybb1qHtzEv+5O3R8EuXTH0UF8DVyeYwbIbQctURkYqWWhXxpustPBDqLC6oogPf4B1bQ
 t6fDtjgFl4qTFbuPEgUFcaloo5SGhjk2wURzM6vwJngpY0RXpr7eLoduP8TEjePClWaoyw/q9
 VjtymHc2ol3lV3GWFa0DG8voi0TWWjeeP8jjw2QhbD+kGK58GNPgI//Y2iV+HX9diVAsBdVBV
 PaeZXJaH9BcKwHAL2PO5RmF37Rgf8mHojGkMR2dmaql4XXHHk8VTrFCKiFVd8I4M1lHSGSzt+
 5txKU0e5NFJHzGuHJoL4gkYag86GXN86kK8I2v/F9nysMmLbtbBkq+IxRRUi88AlXYRS12325
 /i1WBKYJpS6N5ryUSNJ1ZErEWTqPmXyRRKdLeM93VyQgvoHAnFTzBhj2TX3FCd0RZ6TP30rSb
 j0YHzMG9NFJbQ0XxQJdY6vJrBm32HXCGHqxmSeK/j3VCZgbLQUs0T5rOM9zki5XejwTUz5r0E
 9lHWxm/TRq2+p0c48SnwrJYwv3zP7WYx9kOz8nMnoIusJq6utBXz1I5SudTMYuhT1Gq3Ios+O
 kZUJXvi3x7QuG/Je08IdAGBAFX2ozgJXTlqR0POlqEuozSaI933Kjkg8KUBmfyDwOF2xohusa
 ylkCVcDLDHG2FKV//K+JsxKrfnwF5UGPAbCEK02fY3zAI1iPVVsmE+g86fmt4zq57xeKS5ca/
 VsAO2yMY+aKH2g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 10:59:10AM +0200, Robert Richter wrote:

> this patch looks good to me. I made some changes on top of it to
> further ease pointer arithmetic and also fix remaining
> sprintf/snprintf() users as it makes sense to have them all in a
> single change. See below. Boris, please apply.

Thanks Robert for doing this.

Regards,
Len

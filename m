Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBB1E7994
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2Jl3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 05:41:29 -0400
Received: from mout.web.de ([212.227.17.12]:45587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgE2Jl2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 05:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590745249;
        bh=aZeH1OSbrXcB6lW8pIauzi1kVMuPH/P8HDYyy/4BEPQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=s4LgekRtcQb4vjy/4dNc+b1hn5ROUQLScDbzTyfgfakNC9Nj4gbCE8jqQtndCi35x
         0ym7cjunvnpYPZcKXKwyHdsspYPPKzPa2Z5YYsWnwMOblVjLQkp1CB9f7SPZdcUrHO
         8boUiI0FW5UpvecHq2OxJxL4KwIsWdzUc+Nic7Fk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.165.0]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqoJ-1joGXa1LBj-009hq8; Fri, 29
 May 2020 11:40:49 +0200
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
To:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
References: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
 <20200529093644.GC9011@zn.tnic>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c304a0b0-692a-0696-6750-05a3db6a4b42@web.de>
Date:   Fri, 29 May 2020 11:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529093644.GC9011@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aEacErXOHo+W7mjqKit0+/IKbw9Hvh69RxRuItzJNtQha8p1I3G
 TPRNLVzwH5mG1XHlaK9SB5xCgJfHWvbwWP/wcBiERr8LKdSdbK/BAU+jGKKWQyQuXh909xE
 W/+pnC9le6fD1KL3mKjJUJLu6g3ax/sxaNxcCdKo178vLkAhEbOBIhgypE45buf4IzIpzaQ
 twSpxabzR3CiKssa8OvZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vq5CZs5UnAk=:E6E0FVWm1k1JcUuPOpE4k0
 w76c+9YAuyBXdR5ipcmpJ+RB0zfUFCHmMRyy3DMjYUEjGYcGBa6HqtLLVZP3AUWwrbJL97yBn
 F7lm0VX3WE0pevsnEr3IJ1Qd5p2lhzG1MTD/+e9uU1QduDlEexL2cJL6QS7x0D+Roi0iP4sce
 5upTRHvc1j+Vm+Cz3mSuVAAwlB0URLKjg0zorzZdrTPisKbEf4pbdDOyyOfLLcyoRah+PB/FF
 BoxfiNnCmVSTuTfACm2Sl/+b7azVo8m0XCkZLJ5RxKtNJXGIR2h5PgNHUODrHoEybcma+4Idj
 k5V/JoVuSKAhx6iJJRwnlGPAVGWrRfLh+nREr6O2rr+9kXO28ZXYgW5gqd6o9JM9XPx6yP2l6
 LT4ayHlajnGSFUP8ABijBPN2GSiGk+BRv+IrOFWOJpTTpCi7OFYLqOCuc3Wq5tUt5svOuPTpF
 F9yozRhMaFFRDQqjrgTC+RxipCR2s3Q/UeQ3otk6s7haB/vFV3XOc8sNcNIjhvfkRNs6POzpX
 zwkoOtNKafDb8AxBdYqdgX97isRR0d9CAtjvhwojvrBCJ/j0XQcj0WO+kKbfr+MLRi87Yxo1d
 gowg7vkvVTCXcPUiBnwgMyLr6pv/2BKDQPYyugk4IA13VJdwfIPPjJnE7lIl59pkGrX3OSKk6
 88QkBYolNOHpC8qkd4bqF8+290BCe0D4xeCLUBXpuBSJLwNUGpcQVpfyPTyARbxSiUVB+yt2D
 TigKc/myMApRe5QHD7madMKMU0V+isOmKK1hrcy+v3esMfRBJ4VlhQ0oRnC6cXNcoBrU8zFkA
 Mg24qpO/fRpAlhLREWqiVzC9tv+Vqk0TqJACutdMnA80rlq//X9zFGLi4ndBWian+B/VsbbrA
 gpyZ274LxJrKOCCDi4SQCXW4QEy28qqNy654lsbzYmQF0BPLsklP041K/obwjrhqKDM37o88W
 jz6PtesrQHdGgZCyZP5Rg9fx1fJY+El/AWpx2nXCRnN58kKT3KvxXaePpUh5RxhpXodISiQyN
 RmtH0VqYjKxGMJXFVo3zNQX/J0tHGVawR2kRyQsbLjgsO9984PI/j1pWj6SO9FjKdIFtn1aN7
 KqHc25xJEIRPHENWJ/fy5CqipuZcskEgexNrH0T0IBeMTtauvNJmnXp1spaZ03wQgeiYa5wNU
 GTBJ57P20zXoy4dWgIB6XNONeDx+nJffZDHMqhERaRSWHlY2i618bukz2mLrAVWwXzsjpTZ5/
 y+UFZbzUVuPgwnOTg
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> * The label =E2=80=9Cerr_out=E2=80=9D can be replaced by direct return =
statement,
>>   can't it?
>
> No, it cannot. It keeps the error handling code out-of-line so that the
> function body remains readable.

Have we got different programming expectations also around the application
of the Linux coding style?

Regards,
Markus

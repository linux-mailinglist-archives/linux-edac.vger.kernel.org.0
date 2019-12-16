Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B3120223
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLPKRL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 05:17:11 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKRL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Dec 2019 05:17:11 -0500
Received: from [10.11.10.37] ([212.77.180.74]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2Nm2-1ihLP50lkk-003sq6; Mon, 16 Dec 2019 11:17:05 +0100
Subject: Denverton decoding: BIOS performance setting
To:     tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191214121109.8349-1-xiexiuqi@huawei.com>
From:   Hermann Ruckerbauer <Hermann.Ruckerbauer@EyeKnowHow.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Hermann.Ruckerbauer@EyeKnowHow.de; prefer-encrypt=mutual;
 keydata=
 mQGiBEn65uURBACa9V7p8m+Kq00VTZochfOuqtefHJTz0/KK/OeZVPD4ChA3pfDGSMlV5Yui
 eV1BT7GBJ5PqYKXtzocaqkafam+Ad4r3c9+9Mb2NlxKQvmptUApM6lZGlg95ZjAdrowYoCNj
 3Ab72bPs7QEl1OuNJRM9BlsSkngNW3oGKX9CY6x7bwCgm4UMbV/KuF99AjXs1HROfQFdpJcD
 /18y0tapYKnRJ2FSJJDEnPOZSfcO1izvLxh/VBqLBCxLF3oG6S+lEf3Wo1IsDMFbpBY5VfeH
 /R9f9ZiZHc3nz6tyh7dFGP2GoAoe1DvQ2J5jyBDw3XibsvqW/cBOQpFQPU6HD792hYfAxjoN
 AXOT62P1ab5yJgIzDtCnjbRftL67BACSy1BSn5PfounP2N7kv6S7quovNfS0Y+if66ZvlJ3W
 anDj9JU7Yis58olyCq/oZ7Dm6kCxqd3rcBmYI5K32nEpa1d3ZOYKVKtPEHvzXbY0LvuEJU7U
 DBKv0qICe48XDJsN5DnVqefFfiAKL3yhGuV3CvgmCC1uy/jhdBUBkO2Dm7Q3SGVybWFubiBS
 dWNrZXJiYXVlciA8aGVybWFubi5ydWNrZXJiYXVlckBleWVrbm93aG93LmRlPohgBBMRAgAg
 BQJJ+ublAhsjBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQibE9R9St7yLk2gCghmlHwWt0
 mCbveOhPtMAUl25aXAwAn32+uaLL46TMJkoAFsjo6Tb4fFQsuQINBEn65uUQCADYGfXVRYX6
 FG31WplOHJztyAh8MFG9JWTR1K7waadstZGXq7ze3Woo6d+ZqXO7G8KOC3qyLSsIR6WVA640
 buPttZ0gjz/TlMIOhXlu7My49iYeowXRWAhW511xvzfLthmuHJ5FP5z8z8hvcn4yui8zPOsX
 n7EYGD9Iit+e2vjCuBuX/i0XoJKfrhGiPKu/ZlJ1FjGkSeWSD42jKeVtftuFQQxcO7wIZf6Q
 3MSnmyzip8haVFqLzngULVIHhdCRMni3441v/vWxeg2zLuHTbWhQRCSDJYmGdOMIM4xGSgt/
 aHUW6wW63RDy6k9vSTTZ6KurgFX+qdb+0nbJylF+/ZCfAAMFCACDxeDpzBI61AJdEJc5bM7x
 ssiPoo0uDKBeQr+580JvTstel3U3D4zCPSW4ykdZJMRlQcAKOzcD1z6i2xcs8HWbp+Ab2OV4
 tVLjCLr2lBaUkWx8BzBCorCySdvh1KZ0qNkbbqs+CSKjGMQ/XDff7qSar8kvm4ZoFOQ8hAD4
 RW8X1g9fpirw8/o/fYxxiiJzqCvf8p/GUkoau3MrzvDD291PsZpzpOv8gQoN+h1VaxJcdf48
 oKO3U19M2ywbnH5B+0IvLEtZVYFb7GBflQbeOpWcM773z/bYsUQNlYLR8E5Q/NPa+VIUcfXv
 EODkSk6Rw4kDBuqOBjNLr76L7cygEqu3iEkEGBECAAkFAkn65uUCGwwACgkQibE9R9St7yKS
 4wCfaiijO4NkbjbwyirWDlsS6AXTxiIAnAiyJDbwq/ecKxwCclK0TqneUUgF
Message-ID: <2f37cbcc-7f2e-2cfd-8b4f-74fefc767074@EyeKnowHow.de>
Date:   Mon, 16 Dec 2019 11:17:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191214121109.8349-1-xiexiuqi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KzXbQVOT0iHu/Rk+dYvKEQ3/cD87HdpKWirtmMNH9rwqpYNHmy9
 bN/xfJtWV3SzreU5PgTDxvUjxynX+pgyB+cqP6svg4I36LH7Duj8DpkUdSjJtWmZFjk5TQY
 XNqfO+ZPpfnixwFjYByctd/sw1QglkB5FYFyN+KrMzd8gUZVDo+cWN4mkwZXzYxfvWcYt+l
 +4GAYvoO10tCgHDGkGzLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BFc6HJW9IwE=:55T/fIMeZtlUbHw5hTqmrk
 cn3F3dGhv26osB4mmapjlZ5I64gUjE0oRyXLa4iFFiqKBQ4Eh4CFk5tTczzYvzBy0nOk3nOqw
 ZEBr3qY0FU2HWhHnlD09LTNt+qHNE4EaYzz9pi6rp0F2Dl6iRp9XEaprV0uOeb2kIgLMJgnIW
 7KDNAhZ4bpilbCx/4poEMCFldbF5gevWzeVm812X617QBJvKBt2Nhrtm/+oSiB79Oa/B0ZXty
 7q25A70ACPvxVTCqn1BTKeCUKp95nztQi0AUaOzHUacHm5DX+9xX0QCE7N9mGHX3TiCIby/kA
 AJL1MR7MHrVOQJXQQyVnEoOZnInrNMiP5eMudC+ms6ZCwkcAniY/L2W5AgbZ2QBAb+2hzEjNO
 /+8cWkgpiZLP9HBJEsIN942YSr5q3n0h9fzEVBjIO/yGfQ0yNFY5YboKzb1OjhGMjrryy9SAe
 CAmYYw52bAWU2lY/Q/Tvv3GsTTkAtqxZVIsMTlpz1H+F+ddEM5DHF63iBwc0mfLLKqN0VScfl
 ZTvk2zKxK8sCezBQdPent/sqlUjbeWIiZlR6zI8b05tymMbj9qQgnNmkaxiE/nNbySXq0peVf
 oWThhimCA/EGJFr/LWIHqneWPat3aS9tS1n7flXw6eWljI8jzv+PpzxtAO9+vqtjyhTqDZCbm
 liLfh0QwLbuSXhhaVDHGJWoKO0s33dCAH/m3evNFkomFIfL8GdQhdiQl8+/2laBhNHUKMyrQh
 9O36LDS2/30gOH6ip9B3z+jueVL6fcKGpXw9FHZ9onqWyOMX7aWzkA3iDgVH/B4Cdr8/gvJvS
 Oxc4BKgxGDm0BXd1vQ85lfdBHdaZObNEVLumZEak+5/lGDviPvQCyRucda028j5Fd4Xvowfkk
 gWkebGx2K5cW3h+yhoYQoy1PRdgWoxt/5e7tjY1kl2Pz7r3D9nhaBClY659JUD
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

not sure if this is a bit off topic, but I hope to get some answers ...

I looked to the Apollo lake pnd2_edac.c  code, my understandig is, that
this is the same as for denverton.
but in our BIOS is see one point in the memory settings called
"Performance profile"
Selectable is "17_9_13_18", "17_19_6_18" or "17_19_6_7"
This setting seems to be realated to the DMAP table... but for APL there
are just the "standard" configs visible.

Does anybody know if these DMAP settings are different in Denverton vs.
Apollo lake, and how these are decoded in the PND2_edac.c cource code ?
at least I have not found any hint on this performance setting in the
code..

Thanks a lot

-- 

EKH - EyeKnowHow 
Signal Quality - Made in Bavaria
Hermann Ruckerbauer
www.EyeKnowHow.de
Hermann.Ruckerbauer@EyeKnowHow.de
Itzlinger Strasse 21a
94469 Deggendorf
Tel.:	+49 (0)991 / 29 69 29 05
Mobile:	+49 (0)176  / 787 787 77
Fax:	+49 (0)3212 / 121 9008

